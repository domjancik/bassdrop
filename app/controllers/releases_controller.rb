class ReleasesController < ApplicationController
  include Playlistable

  helper TimeHelper

  before_action :set_release, except: [:index, :create, :new, :records, :sets, :videos]

  # GET /releases
  # GET /releases.json
  def index
    if params.has_key? :type

    else
      @releases = policy_scope Release.all
    end
  end

  def records
    @releases = policy_scope Release.record
  end

  def sets
    @sets_video = policy_scope Release.set_video
    @sets_audio = policy_scope Release.set_audio
  end

  def videos
    @aftermovies = policy_scope Release.aftermovie
    @trailers = policy_scope Release.trailer
  end

  # Loads all artist avatars for the given release
  # GET /releases/1/avatars.js
  def avatars
  end

  # GET /releases/1
  # GET /releases/1.json
  def show
    @upcoming_events = policy_scope Event.upcoming
  end

  # GET /releases/new
  def new
    @release = Release.new
    authorize @release
  end

  # GET /releases/1/edit
  def edit
  end

  # POST /releases
  # POST /releases.json
  def create
    @release = Release.new(type_params(release_params))
    authorize @release

    respond_to do |format|
      if @release.save
        format.html { redirect_to @release, notice: 'Release was successfully created.' }
        format.json { render :show, status: :created, location: @release }
        format.json { render :show, status: :created, location: @release }
      else
        format.html { render :new }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /releases/1
  # PATCH/PUT /releases/1.json
  def update
    respond_to do |format|
      if @release.update(type_params(release_params))
        format.html { redirect_to @release, notice: 'Release was successfully updated.' }
        format.json { render :show, status: :ok, location: @release }
      else
        format.html { render :edit }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.json
  def destroy
    @release.destroy
    respond_to do |format|
      format.html { redirect_to releases_url, notice: 'Release was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release
      @release = Release.find_universal(params[:id])
      authorize @release
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def release_params
      params.require(:release).permit(:title, :rel_code, :get_url, :get_text, :release_date,
                                      :release_type, :description, :description_cs,
                                      :playlist_id, :avatar)
    end

    def type_params(params)
      # edited_params = {}.merge params
      # edited_params['release_type'] = edited_params['release_type'].to_i
      #
      # edited_params
      params
    end
end
