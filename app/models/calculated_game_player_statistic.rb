class CalculatedGamePlayerStatistic < ActiveRecord::Base
  
  belongs_to :statistic_type
  belongs_to :team
  belongs_to :game
  belongs_to :player
  attr_accessible :count, :game, :player, :team, :statistic_type
  
end
