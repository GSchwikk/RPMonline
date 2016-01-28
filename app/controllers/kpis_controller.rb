class KpisController < ApplicationController
	before_action :check_org, only: [:new] 
	load_and_authorize_resource 
	before_filter :authorize
	before_action :check_user, only: [:index, :create, :new, :edit, :update, :destroy]

	def index
	@kpis = Kpi.all
	end


	def new
		@kpi = Kpi.new
	end

	def create
		@kpi = Kpi.new(kpi_params)

		respond_to do |format|
	      if @kpi.save
	        format.html { redirect_to @kpi, notice: 'KPI was successfully created.' }
	        format.json { render :show, status: :created, location: @kpi }
	      else
	        format.html { render :new }
	        format.json { render json: @kpi.errors, status: :unprocessable_entity }
	      end
    	end
	end

	def edit
	end

	def update
	@kpi = Kpi.find( params[:kpi_id] )

	respond_to do |format|
	  if @kpi.update(kpi_params)
	    format.html { redirect_to @kpi, notice: 'KPI was successfully updated.' }
	    format.json { respond_with_bip(@kpi) }
	  else
	    format.html { render :edit }
	    format.json { respond_with_bip(@kpi) }
	  end
	end
	end

	def destroy
	@kpi = Kpi.find( params[:kpi_id] )

	@kpi.destroy
		respond_to do |format|
		  format.html { redirect_to :back, notice: 'KPI was successfully destroyed.' }
		  format.json { head :no_content }
		end
	end

	private

    def kpi_params
      params.require(:kpi).permit(:name, :vector, :units, :frequency)
    end

    def check_org
      unless current_user.organisation == @meeting.division.organisation
        redirect_to current_user, :alert => "Sorry, you are not authorised for that"
      end
    end

    def check_user
     unless current_user.admin?
       redirect_to root_url, alert: "Sorry, only super admins can do that!"
     end
    end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to current_user, :alert => exception.message
    end

end