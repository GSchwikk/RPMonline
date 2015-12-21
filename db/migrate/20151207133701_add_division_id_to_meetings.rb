class AddDivisionIdToMeetings < ActiveRecord::Migration
  def change
  	add_column :meetings, :division_id, :integer
  end
end
