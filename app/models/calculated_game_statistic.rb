class CalculatedGameStatistic < ActiveRecord::Base
  belongs_to :statistic_type
  attr_accessible :count, :game_id, :team_id, :statistic_type
 end
