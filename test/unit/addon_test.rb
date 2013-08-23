require 'test_helper'

class AddonTest < ActiveSupport::TestCase
  test 'should_insert_record' do
    c = Container.new :name => 'to_assign'
    assert_difference 'Container.count', 1 do
      c.save
    end
    assert_difference 'Addon.count', 1 do
      a = Addon.new :name => 'assigned', :value => 'sample', :container_id => c.id
      assert a.save
    end
  end

  test 'should_not_insert_record' do
    assert_no_difference 'Addon.count' do
      a = Addon.new :name => 'assigned', :value => 'sample'
      refute a.save
    end
  end

  test 'should_not_insert_empty_record' do
    assert_no_difference 'Addon.count' do
      a = Addon.new
      refute a.save
    end
  end
end
