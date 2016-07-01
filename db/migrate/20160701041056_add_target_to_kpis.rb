class AddTargetToKpis < ActiveRecord::Migration
  def change
    add_column :kpis, :target, :decimal
    remove_column :kpis, :frequency, :string
  end
end
