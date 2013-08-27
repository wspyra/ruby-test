class AddPostalCode < ActiveRecord::Migration
  def change
    add_column :containers, 'postal_code', :string, :limit => 20
  end
end
