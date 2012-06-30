class CalculatedGameStatistic < ActiveRecord::Base
  belongs_to :statistic_type
  belongs_to :team
  belongs_to :game
  attr_accessible :count, :game, :team, :statistic_type
 end
