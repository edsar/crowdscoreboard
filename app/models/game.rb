class Game < ActiveRecord::Base
  attr_accessible :name
  has_many :calculated_game_statistics
  has_many :calculated_game_player_statistics
  
  def team_ids
    team_ids = Set.new
    self.calculated_game_statistics.each do |x|
          team_ids.add(x.team_id)
        end
    return team_ids
  end
  
  def player_ids(team_id)
    player_ids = Set.new
    self.calculated_game_player_statistics.each do |x|
      if(x.team_id==team_id)
        player_ids.add(x.player_id)
      end
    end
    return player_ids
  end
  
 end
