class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :industry
      t.string :image

      t.timestamps null: false
    end
  end
end
