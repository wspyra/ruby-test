class Addon < ActiveRecord::Base

  belongs_to :container

  has_one :contact_email

  has_one :language

  attr_accessible :name, :value, :id, :container_id, :language_id, :contact_email_attributes
  validates_presence_of :name, :value, container_id: {:on => :update}
  accepts_nested_attributes_for :contact_email, :allow_destroy => true, :limit => 1

end
