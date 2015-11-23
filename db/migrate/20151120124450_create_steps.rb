class CreateSteps < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.text :description
      t.date :due_date
      t.string :status
      t.references :user, index: true, foreign_key: true
      t.references :pack, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
