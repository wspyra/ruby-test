class RenameTestToContainer < ActiveRecord::Migration
  def change
    rename_table :tests, :containers
    rename_column :test_addons, :test_id, :container_id
  end
end
