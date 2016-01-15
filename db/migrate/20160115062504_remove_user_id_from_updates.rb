class RemoveUserIdFromUpdates < ActiveRecord::Migration
  def change
  	remove_column :updates, :user_id
  end
end	
