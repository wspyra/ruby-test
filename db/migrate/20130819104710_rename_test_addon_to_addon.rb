class RenameTestAddonToAddon < ActiveRecord::Migration

  def change
    rename_table :test_addons, :addons
  end

end
