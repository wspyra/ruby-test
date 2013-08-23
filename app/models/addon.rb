class Addon < ActiveRecord::Base

  attr_accessible :name, :value, :id, :container_id

  validates_presence_of :name, :value, :container_id

  belongs_to :container, touch: true

end
