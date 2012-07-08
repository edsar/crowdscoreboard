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
    # @player_id = player_id
    #    @stat_id = stat_id
    #    puts "PID #{@player_id}"
    #stat = CumulativeUserPlayerStatistic.new(1,2) unless stat
    stat=CumulativeUserPlayerStatistic.new unless stat
    stat.increment
    collected_stats_map[user_id]=stat
    game_map[rk]=collected_stats_map
    
    Rails.cache.write(gk,game_map)
    stat
  end
  
  # def self.calculate_stats(game_id)
  #    gk = game_key(game_id)
  #    game_map = Rails.cache.read(gk)
  #    return unless game_map
  #    
  #    game_map.keys.each do |key|
  #      collected_stats_map = game_map[key]
  #      puts key
  #    end
  #    
  #  end
  
  def self.game_key(game_id)
    return "game_stats_map." << game_id.to_s 
  end
  
  def self.record_key(user_id,game_id,team_id,player_id,stat_id)
    game_id.to_s << "." << team_id.to_s << "." << player_id.to_s  << "." << stat_id.to_s
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
  
  def self.sayhi
    return "hello"
  end
  
end