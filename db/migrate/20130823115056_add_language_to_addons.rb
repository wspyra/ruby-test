class AddLanguageToAddons < ActiveRecord::Migration
  def change
    add_column :addons, :language_id, :integer, :default => 1
  end
end
