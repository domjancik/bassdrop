class ReleaseMediaController < ApplicationController
  before_action :set_release_medium, only: [:show, :edit, :update, :destroy]

  # GET /release_media
  # GET /release_media.json
  def index
    @release_media = policy_scope ReleaseMedium.all
  end

  # GET /release_media/1
  # GET /release_media/1.json
  def show
  end

  # GET /release_media/new
  def new
    @release_medium = ReleaseMedium.new
    authorize @release_medium
  end

  # GET /release_media/1/edit
  def edit
  end

  # POST /release_media
  # POST /release_media.json
  def create
    @release_medium = ReleaseMedium.new(release_medium_params)
    authorize @release_medium

    respond_to do |format|
      if @release_medium.save
        format.html { redirect_to @release_medium, notice: 'Release medium was successfully created.' }
        format.json { render :show, status: :created, location: @release_medium }
      else
        format.html { render :new }
        format.json { render json: @release_medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /release_media/1
  # PATCH/PUT /release_media/1.json
  def update
    respond_to do |format|
      if @release_medium.update(release_medium_params)
        format.html { redirect_to @release_medium, notice: 'Release medium was successfully updated.' }
        format.json { render :show, status: :ok, location: @release_medium }
      else
        format.html { render :edit }
        format.json { render json: @release_medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /release_media/1
  # DELETE /release_media/1.json
  def destroy
    @release_medium.destroy
    respond_to do |format|
      format.html { redirect_to release_media_url, notice: 'Release medium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release_medium
      @release_medium = ReleaseMedium.find(params[:id])
      authorize @release_medium
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def release_medium_params
      params.require(:release_medium).permit(:release_id, :medium_id, :list_order)
    end
end
