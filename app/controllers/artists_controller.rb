class ArtistsController < ApplicationController
  include Playlistable

  before_action :set_artist, except: [:index, :create, :new]

  ARTIST_GROUPS = %w(bassdrop headliner records supported artist)

  # GET /artists
  # GET /artists.json
  def index
    artist_roles = ARTIST_GROUPS
    @artist_groups = []
    artist_roles.each do |role|
      @artist_groups << {name: role, artists: policy_scope(Artist.send(role))}
    end
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    @upcoming_events = policy_scope Event.upcoming
    @next_event = @artist.events.upcoming.take
  end

  # GET /artists/new
  def new
    @artist = Artist.new
    authorize @artist
  end

  # GET /artists/1/edit
  def edit
    @social = params[:social]
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(artist_params)
    authorize @artist

    respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
      authorize @artist
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:title, :city_id, :playlist_id, :avatar, :description, :link_fb, :link_soundcloud, :link_youtube, :link_instagram, :link_twitter)
    end
end
