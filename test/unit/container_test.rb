require 'test_helper'

class ContainerTest < ActiveSupport::TestCase

  test 'empty values' do

    container = Container.new
    assert !container.save

    container.data = 'asd'
    assert !container.save

    container.position = nil
    assert !container.save

    container.position = 0
    assert !container.save

    container.name = 'qwe'
    assert container.save

    container.position = nil
    assert !container.save

  end

end
