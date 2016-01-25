class CreateKpisAndKpisPacks < ActiveRecord::Migration
  def change
    create_table :kpis do |t|
    	t.string :name
    	t.string :vector
    	t.string :units
    	t.string :frequency

    	t.timestamps null: false
    end

    create_table :kpis_packs, id: false do |t|
    	t.belongs_to :kpi, index: true
    	t.belongs_to :pack, index: true
    end

    create_table :kpi_datapoints do |t|
    	t.belongs_to :kpi, index: true
    	t.date :date
    	t.decimal :value

    	t.timestamps null:false
    end

  end
end
