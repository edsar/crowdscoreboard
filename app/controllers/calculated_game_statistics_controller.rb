class CalculatedGameStatisticsController < ApplicationController
  # GET /calculated_game_statistics
  # GET /calculated_game_statistics.json
  def index
    @calculated_game_statistics = CalculatedGameStatistic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calculated_game_statistics }
    end
  end

  # GET /calculated_game_statistics/1
  # GET /calculated_game_statistics/1.json
  def show
    @calculated_game_statistic = CalculatedGameStatistic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calculated_game_statistic }
    end
  end

  # GET /calculated_game_statistics/new
  # GET /calculated_game_statistics/new.json
  def new
    @calculated_game_statistic = CalculatedGameStatistic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calculated_game_statistic }
    end
  end

  # GET /calculated_game_statistics/1/edit
  def edit
    @calculated_game_statistic = CalculatedGameStatistic.find(params[:id])
  end

  # POST /calculated_game_statistics
  # POST /calculated_game_statistics.json
  def create
    @calculated_game_statistic = CalculatedGameStatistic.new(params[:calculated_game_statistic])

    respond_to do |format|
      if @calculated_game_statistic.save
        format.html { redirect_to @calculated_game_statistic, notice: 'Calculated game statistic was successfully created.' }
        format.json { render json: @calculated_game_statistic, status: :created, location: @calculated_game_statistic }
      else
        format.html { render action: "new" }
        format.json { render json: @calculated_game_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calculated_game_statistics/1
  # PUT /calculated_game_statistics/1.json
  def update
    @calculated_game_statistic = CalculatedGameStatistic.find(params[:id])

    respond_to do |format|
      if @calculated_game_statistic.update_attributes(params[:calculated_game_statistic])
        format.html { redirect_to @calculated_game_statistic, notice: 'Calculated game statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calculated_game_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calculated_game_statistics/1
  # DELETE /calculated_game_statistics/1.json
  def destroy
    @calculated_game_statistic = CalculatedGameStatistic.find(params[:id])
    @calculated_game_statistic.destroy

    respond_to do |format|
      format.html { redirect_to calculated_game_statistics_url }
      format.json { head :no_content }
    end
  end
end
