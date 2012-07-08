class StatisticsCollector
  
  require 'cumulative_user_player_statistic'
  
  def self.add_stat(userstat)
    self.update_game(userstat.game.id)
  end
  
  def self.update_stat(user_id,game_id,team_id,player_id,stat_id)
    gk = game_key(game_id)
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
  
  def self.get_map(game_id)
     gk = game_key(game_id)
     game_map = Rails.cache.fetch(gk){Hash.new}
  end
  
  def self.calculate_stats(game_id)
      gk = game_key(game_id)
      game_map = Rails.cache.read(gk)
      return unless game_map
      
      # we're going to sum it up by team while we're at it
      teams_map=Hash.new
      
      #iterate through keys, which essential iterates over player/statistic type pairs
      game_map.keys.each do |key|
      counts = Array.new
      # for each player get all the counts that have been reported
      collected_stats_map = game_map[key]
        collected_stats_map.values.each do |x| 
        counts << x.count
      end
      # choose the most popular count reported
      calculated_count = mode(counts)  
      stat = CalculatedGamePlayerStatistic.find_or_create_by_statistic_type_id_and_game_id_and_player_id_and_team_id(
        statistic_type_id(key),game_id(key),player_id(key),team_id(key))
      stat.count = calculated_count
      stat.save!
      
      # add that count to the total for this team and stat type
      team_map = teams_map[team_id(key)] 
      team_map = Hash.new unless team_map
      team_record_key = team_id(key).to_s << "." <<  statistic_type_id(key).to_s 
      entry = team_map[team_record_key]
      entry = 0 unless entry
      entry = entry + calculated_count
      team_map[team_record_key]=entry
      teams_map[team_id(key)]=team_map
    end
    
    # create/update all the team records 
    teams_map.keys.each do |team_id|
      team_map=teams_map[team_id]
        team_map.keys.each do |key|
          team_id = key.split(".")[0]
          statistic_type_id =  key.split(".")[0]
          stat = CalculatedGameStatistic.find_or_create_by_statistic_type_id_and_game_id_and_team_id(
              statistic_type_id,game_id,team_id)
          stat.count = team_map[key]
          stat.save!
                
        end
    end  
      
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
     
  def self.game_key(game_id) return "game_stats_map." << game_id.to_s end
   
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
  
  def self.game_last_updated(game_id)
    game_hash = Rails.cache.read(:game_list)
    game_hash[game_id]
  end 
  
  
end