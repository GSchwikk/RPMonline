class KpiDatapointsController < ApplicationController
	respond_to :html, :json



	def updatevalue
		@kpidatapoint = KpiDatapoint.find( params[:id]) 
		respond_to do |format|
		  if @kpidatapoint.update(kpidatapoint_params)
		    head :ok
		    format.json { respond_with_bip(@kpidatapoint) }
		  else
		    format.html { render :edit }
		    format.json { respond_with_bip(@kpidatapoint) }
		  end
		end
	end

	def create
		kpi_datapoint = KpiDatapoint.new kpidatapoint_params 
		kpi_datapoint.save!
		render json: kpi_datapoint, root: true
	end


	private

    def kpidatapoint_params
      params.require(:kpi_datapoint).permit(:date, :value, :kpi_id)
    end

end