class AddUserIdToDivisions < ActiveRecord::Migration
  def change
  	add_column :divisions, :user_id, :integer
  end
end
