class StatisticsCollector
  
  require 'cumulative_user_player_statistic'
  require 'user_reported_statistic_slim'

  @@mutex = Mutex.new

  ## read only methods
  def self.game_log(game_id)
    gk = game_log_key(game_id)
    Rails.cache.read(gk)
  end

  def self.get_map(game_id)
    gk = game_stats_map_key(game_id)
    game_map = Rails.cache.fetch(gk){Hash.new}
  end

  def self.game_last_updated(game_id)
    game_hash = Rails.cache.read(:game_list)
    game_hash[game_id]
  end

  def self.add_tweet_log(tweet)
      tweet_list = Rails.cache.fetch("tweet_log"){Array.new}
      tweet_list.push(tweet)
      Rails.logger.info "Pushing tweet record #{tweet}"
      Rails.cache.write("tweet_log",tweet_list)
  end

  def self.get_tweet_log
    Rails.cache.fetch("tweet_log"){Array.new}
  end

  def self.add_tweet(tweet_record)
    logger =  Rails.logger
    logger.info("Tweet record #{tweet_record.inspect}")
    values = tweet_record.status_text.scan(/\#g(\d+)p(\d+)s(\w+)/).first
    logger.info("Tweet record #{tweet_record.status_text}")
    if (!values || values.count!=3)
       tweet_record.add_error!("Unable to parse tweet, unrecognized format #{tweet_record.status_text}")
    end

    if(!tweet_record.has_error?)
      game_id=values[0]
      player_id=values[1]
      stat_code=values[2]

      statistic_type = StatisticType.first( :conditions => [ "lower(code) = ?", stat_code.downcase ])
      errors.push("Unrecognized statistic type #{stat_code}") unless statistic_type
      game = Game.find(game_id)
      tweet_record.add_error!("Unknown game id #{game_id}") unless game
      player = Player.find(player_id)
      tweet_record.add_error!("Unknown player #{player_id}") unless player

    end
    if(!tweet_record.has_error?)
     game_roster = GameRoster.where("game_id=? and player_id=? ",game_id,player_id).first

      tweet_record.add_error!("Unable to find player #{player_id} on team roster for game #{game_id} ")  unless game_roster
    end

    if(tweet_record.has_error?)
      tweet_record.processed_successfully=false
      tweet_record.processed_at=Date.new
      logger.info("failed to parse tweet #{tweet_record.inspect}")
    else
      logger.info("Successfully parsed tweet, adding stat ")
      tweet_record.processed_successfully=true
      tweet_record.processed_at=Date.new
      add_stat(tweet_record.user_id,game_roster.game.id,game_roster.team.id,game_roster.player.id,statistic_type.id)
    end
    logger.info("Will add tweet log #{tweet_record.inspect}")
    add_tweet_log(tweet_record)
    #respond_to do |format|
    #  if @user_reported_statistic.save
    #    format.html { redirect_to user_reported_statistics_url, notice: 'User reported statistic was successfully created.' }
    #    format.json { render json: @user_reported_statistic, status: :created, location: @user_reported_statistic }
    #  else
    #    format.html { redirect_to user_reported_statistics_url ,  notice: 'User reported statistic was not created.'}
    #    format.json { render json: @user_reported_statistic.errors, status: :unprocessable_entity }
    #  end

    #end
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

    logger =  Logger.new(STDOUT)
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
    Logger.new(STDOUT).info("logger update_stat  #{stat_id}.")
    gk = game_stats_map_key(game_id)
    rk = record_key(user_id,game_id,team_id,player_id,stat_id)
    
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
  

    
  def self.mode(x)
     sorted = x.sort
     a = Array.new
     b = Array.new

     sorted.each do |x| 
        if a.index(x) == nil 
           a << x 
           b << 1 
           else b[a.index(x)] +=1 
         end 
      end
      
     maxval = b.max 
     where = b.index(maxval) 
     return a[where] 
  end
     
  def self.game_log_key(game_id) return "game_log." << game_id.to_s end
  
  def self.game_stats_map_key(game_id) return "game_stats_map." << game_id.to_s end
   
  def self.record_key(user_id,game_id,team_id,player_id,stat_id) game_id.to_s << "." <<
   team_id.to_s << "." << player_id.to_s << "." << stat_id.to_s 
  end
  

  def self.statistic_type_id(recordkey)
    recordkey.split(".")[3]
  end

  def self.player_id(recordkey)
    recordkey.split(".")[2]
  end
  
  def self.team_id(recordkey)
    recordkey.split(".")[1]
  end
  
  def self.game_id(recordkey)
    recordkey.split(".")[0]
  end
  
  def self.update_game(game_id)
    game_hash=Rails.cache.fetch(:game_list){Hash.new}
    game_hash[game_id]=DateTime.now
    Rails.cache.write(:game_list,game_hash)
  end
  

  
  
end