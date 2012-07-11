class UserReportedStatisticSlim
  
  attr_accessor :statistic_type_id
  attr_accessor :game_id
  attr_accessor :team_id 
  attr_accessor :player_id
  attr_accessor :user_id
  
  
  def initialize(user_reported_statistic)
    if !user_reported_statistic.nil?
      
    @statistic_type_id=user_reported_statistic.statistic_type.id  unless user_reported_statistic.statistic_type.nil?
    @game_id = user_reported_statistic.game.id unless user_reported_statistic.game.nil?
    @team_id=user_reported_statistic.team.id unless user_reported_statistic.team.nil?
    @player_id=user_reported_statistic.player.id unless user_reported_statistic.player.nil?
    @user_id=user_reported_statistic.user.id unless user_reported_statistic.user.nil?
    end
  end
  
end