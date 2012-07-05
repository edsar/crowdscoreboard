class StatisticType < ActiveRecord::Base
  attr_accessible :code, :points
#  has_many: calculated_game_player_statistics
#  has_many: calculated_game_statistics

  def self.all_cached
    Rails.cache.fetch('StatisticType.all'){all}
  end
  
  
end
