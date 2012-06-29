class StatisticTypesController < ApplicationController
  # GET /statistic_types
  # GET /statistic_types.json
  def index
    @statistic_types = StatisticType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statistic_types }
    end
  end

  # GET /statistic_types/1
  # GET /statistic_types/1.json
  def show
    @statistic_type = StatisticType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statistic_type }
    end
  end

  # GET /statistic_types/new
  # GET /statistic_types/new.json
  def new
    @statistic_type = StatisticType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statistic_type }
    end
  end

  # GET /statistic_types/1/edit
  def edit
    @statistic_type = StatisticType.find(params[:id])
  end

  # POST /statistic_types
  # POST /statistic_types.json
  def create
    @statistic_type = StatisticType.new(params[:statistic_type])

    respond_to do |format|
      if @statistic_type.save
        format.html { redirect_to @statistic_type, notice: 'Statistic type was successfully created.' }
        format.json { render json: @statistic_type, status: :created, location: @statistic_type }
      else
        format.html { render action: "new" }
        format.json { render json: @statistic_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statistic_types/1
  # PUT /statistic_types/1.json
  def update
    @statistic_type = StatisticType.find(params[:id])

    respond_to do |format|
      if @statistic_type.update_attributes(params[:statistic_type])
        format.html { redirect_to @statistic_type, notice: 'Statistic type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statistic_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistic_types/1
  # DELETE /statistic_types/1.json
  def destroy
    @statistic_type = StatisticType.find(params[:id])
    @statistic_type.destroy

    respond_to do |format|
      format.html { redirect_to statistic_types_url }
      format.json { head :no_content }
    end
  end
end
