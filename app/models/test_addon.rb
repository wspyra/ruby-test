class TestAddon < ActiveRecord::Base

  attr_accessible :name, :value, :id, :test_id

  belongs_to :test, touch: true

end
