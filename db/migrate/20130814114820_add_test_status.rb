class AddTestStatus < ActiveRecord::Migration
  def change
    add_column :tests, 'status_upload', :string, :limit => 12
    add_column :tests, 'status_mail', :string, :limit => 12
  end
end
