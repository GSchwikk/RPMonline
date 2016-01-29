class AddOrganisationIdToKpis < ActiveRecord::Migration
  def change
  	add_column :kpis, :organisation_id, :integer
  end
end
