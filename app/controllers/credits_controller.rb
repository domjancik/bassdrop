class CreditsController < ApplicationController
  before_action :set_credit, only: [:show, :edit, :update, :destroy]
  before_action :set_release, only: [:index, :new, :create]

  # GET /credits
  # GET /credits.json
  def index
    @credits = policy_scope @release.credits
  end

  # GET /credits/1
  # GET /credits/1.json
  def show
  end

  # GET /credits/new
  def new
    @credit = Credit.new
    authorize @credit
  end

  # GET /credits/1/edit
  def edit
    @release = @credit.release
  end

  # POST /credits
  # POST /credits.json
  def create
    @credit = Credit.new(credit_params)
    @credit.release = @release
    authorize @credit

    respond_to do |format|
      if @credit.save
        format.html { redirect_to @credit, notice: 'Credit was successfully created.' }
        format.json { render :show, status: :created, location: @credit }
      else
        format.html { render :new }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credits/1
  # PATCH/PUT /credits/1.json
  def update
    respond_to do |format|
      if @credit.update(credit_params)
        format.html { redirect_to @credit, notice: 'Credit was successfully updated.' }
        format.json { render :show, status: :ok, location: @credit }
      else
        format.html { render :edit }
        format.json { render json: @credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credits/1
  # DELETE /credits/1.json
  def destroy
    @credit.destroy
    respond_to do |format|
      format.html { redirect_to credits_url, notice: 'Credit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit
      @credit = Credit.find(params[:id])
      authorize @credit
    end

    def set_release
      @release = policy_scope Release.find params[:release_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_params
      params.require(:credit).permit(:title, :release_id, :artist_id, :list_order)
    end
end
