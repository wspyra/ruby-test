class ContactEmail < ActiveRecord::Base

  belongs_to :addon

  attr_accessible :id, :email, :addon_id, :updated_at, :created_at

end
