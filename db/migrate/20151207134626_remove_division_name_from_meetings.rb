class RemoveDivisionNameFromMeetings < ActiveRecord::Migration
  def change
  	remove_column :meetings, :division
  end
end
