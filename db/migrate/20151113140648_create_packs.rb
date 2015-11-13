class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :title
      t.string :status
      t.references :meeting

      t.timestamps null: false
    end

    add_index :packs, :meeting_id
  end
end
