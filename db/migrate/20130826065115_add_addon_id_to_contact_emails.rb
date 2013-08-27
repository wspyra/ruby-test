class AddAddonIdToContactEmails < ActiveRecord::Migration
  def change
    add_column :contact_emails, :addon_id, :integer
  end
end
