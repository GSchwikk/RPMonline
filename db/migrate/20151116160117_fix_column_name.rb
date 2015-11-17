class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :updates, :type, :update_type
  	rename_column :updates, :type_id, :update_type_id
  end
end
