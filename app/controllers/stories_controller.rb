class StoriesController < ApplicationController
  include Playlistable
  include Publishable

  PAGE_SIZE = 8;

  before_action :set_story, only: [:show, :edit, :update, :destroy, :publish, :hide]

  # GET /stories
  # GET /stories.json
  def index
    @page = params[:page].to_i
    offset = @page * PAGE_SIZE
    @stories = policy_scope Story.all.limit(PAGE_SIZE).offset(offset)
    @last_page = offset + PAGE_SIZE >= (policy_scope Story.all).size
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    @upcoming_events = policy_scope Event.upcoming
  end

  # GET /stories/new
  def new
    @story = Story.new
    authorize @story
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new(story_params)
    authorize @story

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    authorize @story

    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
      authorize @story
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :description, :release_id, :artist_id, :event_id, :playlist_id, :author_id, :published_at, :published)
    end
end
