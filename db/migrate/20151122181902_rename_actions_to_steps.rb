class RenameActionsToSteps < ActiveRecord::Migration
  def change
  	rename_table :Actions, :Steps
  end
end
