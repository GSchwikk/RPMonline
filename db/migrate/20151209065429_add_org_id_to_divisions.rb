class AddOrgIdToDivisions < ActiveRecord::Migration
  def change
  	add_column :divisions, :organisation_id, :integer
  end
end
