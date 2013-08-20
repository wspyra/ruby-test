class Addon < ActiveRecord::Base

  attr_accessible :name, :value, :id, :test_id

  belongs_to :container, touch: true

end
