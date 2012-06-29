class CalculatedGamePlayerStatistic < ActiveRecord::Base
  belongs_to :stat_type
  attr_accessible :count, :game_id, :player_id, :team_id
end
