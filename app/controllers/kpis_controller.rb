class KpisController < ApplicationController
	before_action :set_organisation, only: [:new, :edit, :create, :destroy, :index]  
	load_and_authorize_resource param_method: :kpi_params 
	#before_filter :authorize
	before_action :check_user, only: [:index, :create, :new, :edit, :update, :destroy]

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
		@pack_ids << @pack.id


        if @kpi.update_attributes(:pack_ids => @pack_ids)
            redirect_to @pack, :notice => "KPI was successfully added"
        else
            render "index"
        end 

		# if @kpi.update(kpi_params)
		#     format.html { redirect_to @pack, notice: 'KPI was successfully added.' }
		#     format.json { respond_with_bip(@kpi) }
		#   else
		#     format.html { render :edit }
		#     format.json { respond_with_bip(@kpi) }
		#  end

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

    def check_user
     unless current_user.admin?
       redirect_to root_url, alert: "Sorry, only super admins can do that!"
     end
    end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to current_user, :alert => exception.message
    end

end