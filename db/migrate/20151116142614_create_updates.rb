class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.text :text
      t.string :type
      t.integer :type_id
      t.date :date

      t.timestamps null: false
    end
  end
end
