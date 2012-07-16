class UserReportedStatisticsController < ApplicationController
  
  require "statistics_collector"
  require "user_reported_statistic_slim"
  
  
  # GET /user_reported_statistics
  # GET /user_reported_statistics.json
  def index
     statistic_types = StatisticType.all
     @stat_type_map=Hash.new
     statistic_types.each do |x|
       @stat_type_map[x.id]=x.code
     end
     @stats_log_entries = Rails.cache.fetch("user_stats_log"){Array.new}
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_reported_statistics }
    end
  end

  # GET /user_reported_statistics/1
  # GET /user_reported_statistics/1.json
  def show
    @user_reported_statistic = UserReportedStatistic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_reported_statistic }
    end
  end

  # GET /user_reported_statistics/new
  # GET /user_reported_statistics/new.json
  def new
    @user_reported_statistic = UserReportedStatistic.new
    @statistic_types = StatisticType.all
    @games = Game.all
    @teams = Team.all
    @players = Player.all
    @users = User.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_reported_statistic }
    end
  end

  # GET /user_reported_statistics/1/edit
  def edit
    @user_reported_statistic = UserReportedStatistic.find(params[:id])
  end

  # POST /user_reported_statistics
  # POST /user_reported_statistics.json
  def create
    @user_reported_statistic = UserReportedStatistic.new()
     stat_params=params[:user_reported_statistic]


    @tweet = params[:tweet]
     values = @tweet.scan(/\#g(\d+)p(\d+)s(\w+)/).first

    @user_reported_statistic.errors.add("Unable to parse tweet #{@tweet}") unless values.count ==3

     game_id=values[0]
     player_id=values[1]
     stat_code=values[2]

    @user_reported_statistic.user=User.find(stat_params[:user])

    statistic_type = StatisticType.first( :conditions => [ "lower(code) = ?", stat_code.downcase ])
    game = Game.find(game_id)
    player = Player.find(player_id)
    @user_reported_statistic.statistic_type=statistic_type
    @user_reported_statistic.game=game
    @user_reported_statistic.player=player

    game_roster = GameRoster.find_by_game_id_and_player_id(@user_reported_statistic.game.id,@user_reported_statistic.player.id)
     @user_reported_statistic.team=game_roster.team

     logger.info("logger create #{@user_reported_statistic}")
    urs =    @user_reported_statistic
     StatisticsCollector.update_stat(urs.user.id,urs.game.id,urs.team.id,urs.player.id,urs.statistic_type.id)
     logger.info("logger update_stat")
     log = Rails.cache.fetch("user_stats_log"){Array.new}
     log.push(UserReportedStatisticSlim.new(@user_reported_statistic))
     Rails.cache.write("user_stats_log",log)
     
    respond_to do |format|
      if @user_reported_statistic.save
                  format.html { redirect_to user_reported_statistics_url, notice: 'User reported statistic was successfully created.' }
                  format.json { render json: @user_reported_statistic, status: :created, location: @user_reported_statistic }
                else
                  format.html { render action: "new" }
                  format.json { render json: @user_reported_statistic.errors, status: :unprocessable_entity }
                end
     
    end
  end

  # PUT /user_reported_statistics/1
  # PUT /user_reported_statistics/1.json
  def update
    @user_reported_statistic = UserReportedStatistic.find(params[:id])
     stat_params=params[:user_reported_statistic]
     @user_reported_statistic.statistic_type=StatisticType.find(stat_params[:statistic_type])
     @user_reported_statistic.game=Game.find(stat_params[:game])
     @user_reported_statistic.team=Team.find(stat_params[:team])
     @user_reported_statistic.player=Player.find(stat_params[:player])
     @user_reported_statistic.user=User.find(stat_params[:user])

    respond_to do |format|
      if @user_reported_statistic.update
        format.html { redirect_to @user_reported_statistic, notice: 'User reported statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_reported_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_reported_statistics/1
  # DELETE /user_reported_statistics/1.json
  def destroy
    @user_reported_statistic = UserReportedStatistic.find(params[:id])
    @user_reported_statistic.destroy

    respond_to do |format|
      format.html { redirect_to user_reported_statistics_url }
      format.json { head :no_content }
    end
  end
end
