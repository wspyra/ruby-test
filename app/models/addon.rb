class Addon < ActiveRecord::Base

  belongs_to :container, touch: true

  attr_accessible :name, :value, :id, :container_id

  validates_presence_of :name, :value, :container_id => {:on => :update}

end
