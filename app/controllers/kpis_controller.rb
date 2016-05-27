class KpisController < ApplicationController
	before_action :set_organisation, only: [:new, :edit, :create, :destroy, :index, :updatepack, :updatevalues]  
	load_and_authorize_resource param_method: :kpi_params 
	#before_filter :authorize
	#before_action :check_user, only: [:index, :create, :new, :edit, :update, :destroy]

	def index
		@kpis = Kpi.where(organisation_id: @organisation.id)
		
		if params[:pack]
			@packs = Pack.all
			@pack = Pack.find( params[:pack]) 
		end
	end

	def new
		@kpi = Kpi.new
	end

	def create
		@kpi = Kpi.new(kpi_params)
		@kpi.organisation_id = @organisation.id

		respond_to do |format|
	      if @kpi.save
	        format.html { redirect_to organisation_kpis_path, notice: 'KPI was successfully created.' }
	        format.json { render :show, status: :created, location: @kpi }
	      else
	        format.html { render :new }
	        format.json { render json: @kpi.errors, status: :unprocessable_entity }
	      end
    	end
	end

	def edit
		
	end

	def updatepack
		@kpi = Kpi.find( params[:id] )

		@pack = Pack.find( params[:pack])
		@pack_ids = @kpi.pack_ids
		
		#if change = 1, then remove the pack id from the kpi
		if params[:change] == "1"
			@pack_ids.delete_if {|a| a == @pack.id} 

	        if @kpi.update_attributes(:pack_ids => @pack_ids)
	            redirect_to organisation_kpis_path(@organisation, pack: @pack.id), :notice => "KPI was successfully removed"
	        else
	            render "index"
	        end 			
		else
			#if change = 2, then add the pack id from the kpi
			@pack_ids << @pack.id

	        if @kpi.update_attributes(:pack_ids => @pack_ids)
	            redirect_to organisation_kpis_path(@organisation, pack: @pack.id), :notice => "KPI was successfully added"
	        else
	            render "index"
	        end 
	    end

	end

	def updatevalues
		@kpis = Kpi.where(organisation_id: @organisation.id)

		if params[:event]
			date = Date.new(*params["event"].values.map(&:to_i))
			#period = params[:start_date]
			#date = Date.new period[year].to_i, period[month].to_i, period[day].to_i
			@week1 = date.beginning_of_week
			@week2 = (date.beginning_of_week) -7
			@week3 = (date.beginning_of_week) - 14
			@week4 = (date.beginning_of_week) - 21

		else
			@week1 = 1.week.ago.beginning_of_week
			@week2 = 2.week.ago.beginning_of_week
			@week3 = 3.week.ago.beginning_of_week
			@week4 = 4.week.ago.beginning_of_week
	    end

	end

	def update
		@kpi = Kpi.find( params[:id] )
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
		@kpi = Kpi.find( params[:id] )

		@kpi.destroy
		respond_to do |format|
		  format.html { redirect_to :back, notice: 'KPI was successfully destroyed.' }
		  format.json { head :no_content }
		end
	end

	private

    def kpi_params
      params.require(:kpi).permit(:name, :vector, :units, :frequency,:organisation_id, :pack_ids => [])
    end

    def set_organisation
      @organisation = current_user.organisation
    end

    # def check_user
    #  unless current_user.admin?
    #    redirect_to root_url, alert: "Sorry, only super admins can do that!"
    #  end
    # end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to current_user, :alert => exception.message
    end

end