class CalculatedPlayerStatisticsController < ApplicationController
  # GET /calculated_player_statistics
  # GET /calculated_player_statistics.json
  def index
    @calculated_player_statistics = CalculatedPlayerStatistic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calculated_player_statistics }
    end
  end

  # GET /calculated_player_statistics/1
  # GET /calculated_player_statistics/1.json
  def show
    @calculated_player_statistic = CalculatedPlayerStatistic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calculated_player_statistic }
    end
  end

  # GET /calculated_player_statistics/new
  # GET /calculated_player_statistics/new.json
  def new
    @calculated_player_statistic = CalculatedPlayerStatistic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calculated_player_statistic }
    end
  end

  # GET /calculated_player_statistics/1/edit
  def edit
    @calculated_player_statistic = CalculatedPlayerStatistic.find(params[:id])
  end

  # POST /calculated_player_statistics
  # POST /calculated_player_statistics.json
  def create
    @calculated_player_statistic = CalculatedPlayerStatistic.new(params[:calculated_player_statistic])

    respond_to do |format|
      if @calculated_player_statistic.save
        format.html { redirect_to @calculated_player_statistic, notice: 'Calculated player statistic was successfully created.' }
        format.json { render json: @calculated_player_statistic, status: :created, location: @calculated_player_statistic }
      else
        format.html { render action: "new" }
        format.json { render json: @calculated_player_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calculated_player_statistics/1
  # PUT /calculated_player_statistics/1.json
  def update
    @calculated_player_statistic = CalculatedPlayerStatistic.find(params[:id])

    respond_to do |format|
      if @calculated_player_statistic.update_attributes(params[:calculated_player_statistic])
        format.html { redirect_to @calculated_player_statistic, notice: 'Calculated player statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calculated_player_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calculated_player_statistics/1
  # DELETE /calculated_player_statistics/1.json
  def destroy
    @calculated_player_statistic = CalculatedPlayerStatistic.find(params[:id])
    @calculated_player_statistic.destroy

    respond_to do |format|
      format.html { redirect_to calculated_player_statistics_url }
      format.json { head :no_content }
    end
  end
end
