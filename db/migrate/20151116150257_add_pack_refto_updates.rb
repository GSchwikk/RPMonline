class AddPackReftoUpdates < ActiveRecord::Migration
  def change
  	add_reference :updates, :pack, index: true
  end
end
