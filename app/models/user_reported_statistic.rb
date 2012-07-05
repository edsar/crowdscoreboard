class UserReportedStatistic < ActiveRecord::Base
  belongs_to :statistic_type
  belongs_to :game
  belongs_to :team
  belongs_to :player
  belongs_to :user
  attr_accessible :statistic_type, :game, :team, :player, :user, :statistic_type_attributes
  accepts_nested_attributes_for :statistic_type, :game, :team, :player, :user
end
