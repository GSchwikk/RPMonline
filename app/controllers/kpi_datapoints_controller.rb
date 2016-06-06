class KpiDatapointsController < ApplicationController
	respond_to :html, :json



	def updatevalue
		@kpidatapoint = KpiDatapoint.find( params[:id]) 
		respond_to do |format|
		  if @kpidatapoint.update(kpi_params)
		    head :ok
		    format.json { respond_with_bip(@kpidatapoint) }
		  else
		    format.html { render :edit }
		    format.json { respond_with_bip(@kpidatapoint) }
		  end
		end
	end

	private

    def kpi_params
      params.require(:kpi_datapoint).permit(:value, :date, :kpi_id)
    end

end