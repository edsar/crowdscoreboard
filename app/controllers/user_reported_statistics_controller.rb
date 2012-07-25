class UserReportedStatisticsController < ApplicationController
  
  require "statistics_collector"
  require "user_reported_statistic_slim"
  require 'tweet_record'



  # GET /user_reported_statistics
  # GET /user_reported_statistics.json
  def index
     statistic_types = StatisticType.all
     @stat_type_map=Hash.new
     statistic_types.each do |x|
       @stat_type_map[x.id]=x.code
     end
     @stats_log_entries = Rails.cache.fetch("user_stats_log"){Array.new}
     @tweet_log = TweetCollector.get_tweet_log
    respond_to do |format|
      format.html # index.html.erb
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

    #player = Player.all.sample
    #game = Game.all.sample
    #tr = TweetRecord.new
    #tr.user_screen_name="rebeccag_dev"
    #tr.user_twitter_id=1234567890123
    #tr.status_text="@c2sb #g#{game.id}p#{player.id}sFGM"
    #Rails.logger.info "Sending tweet #{tr.inspect}"
    #TweetCollector.add_tweet(tr)
    ##StatisticsCollector.add_tweet(68,"#g17p#{player.id}sFGM")
    #Rails.logger.info "Submitted tweet for player #{player.id} - #{player.name}"
    #Rails.logger.info("Tweet log #{StatisticsCollector.get_tweet_log.last.inspect}")
    #has_error = false


    @user_reported_statistic = UserReportedStatistic.new()
    stat_params=params[:user_reported_statistic]
    @tweet = params[:tweet]
    user_id = stat_params[:user]
    tr = TweetRecord.new
    tr.status_text=@tweet
    tr.user_id=   user_id
    TweetCollector.add_tweet(tr)
    @user_reported_statistic = UserReportedStatistic.new

    if tr.has_error?
       @statistic_types = StatisticType.all
       @games = Game.all
       @teams = Team.all
       @players = Player.all
       @users = User.all
       tr.error_msgs.each do | x|
        @user_reported_statistic.errors.add(:tweet,x)
      end
    end
    logger.info("logger update_stat")

    respond_to do |format|
      if tr.has_error?
        format.html { render action: "new" }
        format.json { render json: @user_reported_statistic.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to user_reported_statistics_url, notice: 'User reported statistic was successfully created.' }
        format.json { render json: @user_reported_statistic, status: :created, location: @user_reported_statistic }
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
