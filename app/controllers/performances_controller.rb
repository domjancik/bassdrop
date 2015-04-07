class PerformancesController < ApplicationController
  before_action :set_performance, only: [:show, :edit, :update, :destroy]
  before_action :set_event, only: [:index, :new, :create]
  before_action :authenticate_admin!

  # GET /performances
  # GET /performances.json
  def index
    @performances = policy_scope @event.performances
  end

  # GET /performances/1
  # GET /performances/1.json
  def show
  end

  # GET /performances/new
  def new
    @performance = Performance.new
    authorize @performance
  end

  # GET /performances/1/edit
  def edit
    @performance.date_start = @performance.date_end = @performance.event.date_start if params.has_key? :set_date
    event = @performance.event

    @other_performances = event.performances
    @stages = nil
    venue = event.venue
    @stages = @performance.event.venue.stages unless venue.nil?
  end

  # POST /performances
  # POST /performances.json
  def create
    @performance = Performance.new(performance_params)
    @performance.event = @event

    authorize @performance

    respond_to do |format|
      if @performance.save
        format.html { redirect_to event_performances_url(@event), notice: 'Performance was successfully created.' }
        format.json { render :show, status: :created, location: @performance }
      else
        format.html { render :new }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performances/1
  # PATCH/PUT /performances/1.json
  def update
    respond_to do |format|
      if @performance.update(performance_params)
        format.html { redirect_to @performance, notice: 'Performance was successfully updated.' }
        format.json { render :show, status: :ok, location: @performance }
      else
        format.html { render :edit }
        format.json { render json: @performance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performances/1
  # DELETE /performances/1.json
  def destroy
    @performance.destroy
    respond_to do |format|
      format.html { redirect_to event_performances_url(@performance.event), notice: 'Performance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performance
      @performance = Performance.find(params[:id])
      authorize @performance
    end

    def set_event
      @event = policy_scope Event.find params[:event_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performance_params
      params.require(:performance).permit(:event_id, :artist_id, :stage_id, :date_start, :date_end, :is_headliner, :b2b_id)
    end
end
