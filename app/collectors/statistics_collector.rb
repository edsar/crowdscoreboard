class StatisticsCollector
  
  require 'cumulative_user_player_statistic'
  require 'user_reported_statistic_slim'
  require 'tweet_record'

  @@mutex = Mutex.new

  ## read only methods
  def self.game_log(game_id)
    gk = game_log_key(game_id)
    Rails.cache.read(gk)
  end

  def self.get_map(game_id)
    gk = game_stats_map_key(game_id)
    Rails.cache.fetch(gk){Hash.new}
  end

  def self.game_last_updated(game_id)
    game_hash = Rails.cache.read(:game_list)
    game_hash[game_id]
  end


  
  def self.add_stat(user_id,game_id,team_id,player_id,stat_id)
    @@mutex.synchronize do
    update_game(game_id)
    update_stat(user_id,game_id,team_id,player_id,stat_id)
    stat = UserReportedStatisticSlim.new(nil)
    stat.set_attrs(user_id,game_id,team_id,player_id,stat_id)
    add_game_log(game_id,stat)
    end
  end

  def self.clear_cache(game_id)
    @@mutex.synchronize do
    Rails.cache.delete(game_stats_map_key(game_id))
    Rails.cache.delete(game_log_key(game_id))
    end
  end



  def self.calculate_stats(game_id)
    @@mutex.synchronize do

    logger =  Rails.logger
    CalculatedGamePlayerStatistic.delete_all(["game_id=?",game_id])
    CalculatedGameStatistic.delete_all(["game_id=?",game_id])


    logger.info("calculating stats for #{game_id}")
    gk = game_stats_map_key(game_id)
    game_map = Rails.cache.read(gk)
    logger.info("game map : #{game_map}")
    return unless game_map

    # we're going to sum it up by team while we're at it
    teams_map=Hash.new

    #iterate through keys, which essential iterates over player/statistic type pairs
    game_map.keys.each do |key|
      logger.info("got key #{key}")

      counts = Array.new
      # for each player get all the counts that have been reported
      collected_stats_map = game_map[key]
      collected_stats_map.values.each do |x|
        counts << x.count
      end
      logger.info("counts are #{counts}")

      # choose the most popular count reported
      calculated_count = mode(counts)
      logger.info("calculated_count : #{calculated_count}")
      stat = CalculatedGamePlayerStatistic.find_or_create_by_statistic_type_id_and_game_id_and_player_id_and_team_id(
          statistic_type_id(key),game_id(key),player_id(key),team_id(key))
      stat.count = calculated_count
      stat.save!

      logger.info("saved #{stat.inspect}")

      # add that count to the total for this team and stat type
      logger.info("team map #{teams_map[team_id(key)].inspect}")
      team_map = teams_map[team_id(key)]
      team_map = Hash.new unless team_map
      team_record_key = team_id(key).to_s << "." <<  statistic_type_id(key).to_s
      entry = team_map[team_record_key]
      entry = 0 unless entry
      entry = entry + calculated_count
      logger.info("team entry #{entry.inspect}")

      team_map[team_record_key]=entry
      teams_map[team_id(key)]=team_map
      logger.info("team map #{teams_map[team_id(key)].inspect}")

    end
    logger.info("about to save all team entries")

    # create/update all the team records
    teams_map.keys.each do |team_id|
      logger.info("team id #{team_id}")

      team_map=teams_map[team_id]
      logger.info("team map #{team_map}")

      team_map.keys.each do |key|
        logger.info("key #{key}")
        team_id = key.split(".")[0]
        statistic_type_id =  key.split(".")[1]
        logger.info("team #{team_id} stat #{statistic_type_id} team #{team_id}")
        stat = CalculatedGameStatistic.find_or_create_by_statistic_type_id_and_game_id_and_team_id(
            statistic_type_id,game_id,team_id)
        stat.count = team_map[key]
        stat.save!

        logger.info("saved team entry #{stat.inspect}")
        end
      end
    end

  end

  private
   def self.add_game_log(game_id,stat)
      gk = game_log_key(game_id)
      game_log = Rails.cache.fetch(gk){Array.new}
      game_log.push(stat)
      Rails.cache.write(gk,game_log)
    end

 
  def self.update_stat(user_id,game_id,team_id,player_id,stat_id)
    Rails.logger.info("logger update_stat  #{stat_id}.")
    gk = game_stats_map_key(game_id)
    rk = record_key(game_id,team_id,player_id,stat_id)
    
    # cache contains a map for each game
    game_map = Rails.cache.fetch(gk){Hash.new}
    
    # for each game there is a map indexed by the record key
    # which is basically which player & stat we're talking about
    # but including some meta info (game,team) in the key for convenience
    collected_stats_map = game_map[rk]
    
    collected_stats_map = Hash.new unless collected_stats_map
    
    # we want to increment the count on this user's report for this stat type, player
    stat = collected_stats_map[user_id]
    stat = CumulativeUserPlayerStatistic.new(player_id,stat_id) unless stat
    stat.increment
    collected_stats_map[user_id]=stat
    game_map[rk]=collected_stats_map
    
    Rails.cache.write(gk,game_map)
    stat
  end
  

    
  def self.mode(arr)
     sorted = arr.sort
     a = Array.new
     b = Array.new

     sorted.each do |x| 
        if a.index(x) == nil 
           a << x 
           b << 1 
           else b[a.index(x)] +=1 
         end 
      end
      
     max_val = b.max
     where = b.index(max_val)
     return a[where] 
  end
     
  def self.game_log_key(game_id) return "game_log." << game_id.to_s end
  
  def self.game_stats_map_key(game_id) return "game_stats_map." << game_id.to_s end
   
  def self.record_key(game_id,team_id,player_id,stat_id) game_id.to_s << "." <<
   team_id.to_s << "." << player_id.to_s << "." << stat_id.to_s 
  end
  

  def self.statistic_type_id(record_key)
    record_key.split(".")[3]
  end

  def self.player_id(record_key)
    record_key.split(".")[2]
  end
  
  def self.team_id(record_key)
    record_key.split(".")[1]
  end
  
  def self.game_id(record_key)
    record_key.split(".")[0]
  end
  
  def self.update_game(game_id)
    game_hash=Rails.cache.fetch(:game_list){Hash.new}
    game_hash[game_id]=DateTime.now
    Rails.cache.write(:game_list,game_hash)
  end
  

  
  
end