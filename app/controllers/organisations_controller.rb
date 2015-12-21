class OrganisationsController < ApplicationController
  load_and_authorize_resource 
  before_action :set_organisation, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:index, :create, :new, :destroy]

  # GET /organisations
  # GET /organisations.json
  def index
    @organisations = Organisation.all
  end

  # GET /organisations/1
  # GET /organisations/1.json
  def show
    @divisions = Division.where(organisation_id: @organisation.id)

  end

  # GET /organisations/new
  def new
    @organisation = Organisation.new
  end

  # GET /organisations/1/edit
  def edit
  end

  # POST /organisations
  # POST /organisations.json
  def create
    @organisation = Organisation.new(organisation_params) 

    respond_to do |format|
      if @organisation.save
        format.html { redirect_to @organisation, notice: 'Organisation was successfully created.' }
        format.json { render :show, status: :created, location: @organisation }
      else
        format.html { render :new }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organisations/1
  # PATCH/PUT /organisations/1.json
  def update
    respond_to do |format|
      if @organisation.update(organisation_params)
        format.html { redirect_to @organisation, notice: 'Organisation was successfully updated.' }
        format.json { render :show, status: :ok, location: @organisation }
      else
        format.html { render :edit }
        format.json { render json: @organisation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organisations/1
  # DELETE /organisations/1.json
  def destroy
    @organisation.destroy
    respond_to do |format|
      format.html { redirect_to organisations_url, notice: 'Organisation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to current_user, :alert => exception.message
    end

    def check_user
     unless current_user.admin?
       redirect_to root_url, alert: "Sorry, only super admins can do that!"
     end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organisation_params
      params.require(:organisation).permit(:name, :industry, :image)
    end
end
