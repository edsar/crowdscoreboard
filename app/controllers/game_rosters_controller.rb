class GameRostersController < ApplicationController
  # GET /game_rosters
  # GET /game_rosters.json
  def index
    @game_rosters = GameRoster.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_rosters }
    end
  end

  # GET /game_rosters/1
  # GET /game_rosters/1.json
  def show
    @game_roster = GameRoster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_roster }
    end
  end

  # GET /game_rosters/new
  # GET /game_rosters/new.json
  def new
    @game_roster = GameRoster.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_roster }
    end
  end

  # GET /game_rosters/1/edit
  def edit
    @game_roster = GameRoster.find(params[:id])
  end

  # POST /game_rosters
  # POST /game_rosters.json
  def create
    @game_roster = GameRoster.new(params[:game_roster])

    respond_to do |format|
      if @game_roster.save
        format.html { redirect_to @game_roster, notice: 'Game roster was successfully created.' }
        format.json { render json: @game_roster, status: :created, location: @game_roster }
      else
        format.html { render action: "new" }
        format.json { render json: @game_roster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_rosters/1
  # PUT /game_rosters/1.json
  def update
    @game_roster = GameRoster.find(params[:id])

    respond_to do |format|
      if @game_roster.update_attributes(params[:game_roster])
        format.html { redirect_to @game_roster, notice: 'Game roster was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_roster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_rosters/1
  # DELETE /game_rosters/1.json
  def destroy
    @game_roster = GameRoster.find(params[:id])
    @game_roster.destroy

    respond_to do |format|
      format.html { redirect_to game_rosters_url }
      format.json { head :no_content }
    end
  end
end
