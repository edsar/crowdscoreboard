class GamePresenter < BasePresenter
  presents :game
 
  def parse
    @teams = Set.new
    @playerStats = Hash.new
    @roster = Hash.new
    @teamStats = Hash.new
    game.calculated_game_player_statistics.each do |x|
      
      @teams.add(x.team)
      
      teamPlayerList = @roster[x.team]
      teamPlayerList ||= Set.new
      teamPlayerList.add(x.player)
      @roster[x.team]=teamPlayerList
      
      playerStatsList = @playerStats[x.player]
      playerStatsList ||= Set.new
      playerStatsList.add(x)
      @playerStats[x.player]=playerStatsList
    end
    
    game.calculated_game_statistics.each do |x|
      teamStatsList = @teamStats[x.team]
      teamStatsList ||= Set.new
      teamStatsList.add(x)
      @teamStats[x.team]=teamStatsList
    end
    
    @ready=true
  end
  
  
  def players(team)
    parse unless @ready
    @roster[team]
  end
  
  def player_stats(player)
    parse unless @ready
    @playerStats[player]
  end
  
  def player_stats_display(player)
    parse unless @ready
    stats = @playerStats[player]
    message = ""
    stats.each_with_index do |s,index|
      message << ", " unless index==0
      message << "#{s.count} #{s.statistic_type.code}"
    end
    return message
  end
  
  def player_total(player)
     parse unless @ready
      stats = @playerStats[player]
      total=0
      stats.each do |s|
        total=total+(s.count*s.statistic_type.points)
      end
      return total
  end
  
  def team_stats(team)
     parse unless @ready
     @teamStats[team]
   end

  def team_stats_display(team)
     parse unless @ready
      stats = @teamStats[team]
      message = ""
      if(stats)
        stats.each_with_index do |s,index|
          message << ", " unless index==0
          message << "#{s.count} #{s.statistic_type.code}"
        end
      end
      return message
    end
    
    def team_total(team)
       parse unless @ready
        stats = @teamStats[team]
        total=0
        if (stats)
          stats.each do |s|
            total=total+(s.count*s.statistic_type.points)
          end
        end
        return total
    end
  
  def teams
    parse unless @ready
    @teams
  end
 
  def name
    game.name
  end
  
  
end