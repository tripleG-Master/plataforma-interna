class JoboffersController < ApplicationController
  before_action :set_joboffer, only: %i[ show edit update destroy ]
  before_action :authenticate_user
  before_action :authenticate_admin, only: %i[ create edit update destroy ]
  
  before_action :set_user_profile


  # GET /joboffers or /joboffers.json
  def index
    @joboffers = Joboffer.all
  end

  # GET /joboffers/1 or /joboffers/1.json
  def show
    @joboffer = Joboffer.find(params[:id])
    @applications = @joboffer.applications
  end

  # GET /joboffers/new
  def new
    @joboffer = Joboffer.new
  end

  # GET /joboffers/1/edit
  def edit
  end

  # POST /joboffers or /joboffers.json
  def create
    @joboffer = Joboffer.new(joboffer_params)
    @joboffer.user = current_user
    @joboffer.salary = @joboffer.salary.to_s.gsub(/[^\d\.]/, '').to_f

    respond_to do |format|
      if @joboffer.save
        format.html { redirect_to @joboffer, notice: "Joboffer was successfully created." }
        format.json { render :show, status: :created, location: @joboffer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @joboffer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /joboffers/1 or /joboffers/1.json
  def update
    respond_to do |format|
      if @joboffer.update(joboffer_params)
        format.html { redirect_to @joboffer, notice: "Joboffer was successfully updated." }
        format.json { render :show, status: :ok, location: @joboffer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @joboffer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /joboffers/1 or /joboffers/1.json
  def destroy
    @joboffer.destroy!

    respond_to do |format|
      format.html { redirect_to joboffers_path, status: :see_other, notice: "Joboffer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_joboffer
      @joboffer = Joboffer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def joboffer_params
      params.require(:joboffer).permit(:title, :description)
    end

end
