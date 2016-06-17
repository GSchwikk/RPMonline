class DataImportsController < ApplicationController
  
  def new
    @data_import = DataImport.new
  end

  def create
    @data_import = DataImport.new(params[:data_import])
    if @data_import.save
      redirect_to updatevalues_organisation_kpis_path(current_user.organisation), notice: "Imported values successfully."
    else
      render :new
    end
  end

  private

  def dataimport_params
    params.require(:data_import).permit(:value,:date,:kpi_id)
  end


end