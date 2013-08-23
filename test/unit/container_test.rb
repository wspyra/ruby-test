require 'test_helper'

class ContainerTest < ActiveSupport::TestCase
  def test_should_create_container
    assert_difference 'Container.count' do
      c = create_container
      assert !c.new_record?, "#{c.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_name
    assert_no_difference 'Container.count' do
      u = create_container(:name => nil)
      assert u.errors.include?(:name)
    end
  end

  def test_empty_values
    c = Container.new

    assert_no_difference 'Container.count' do
      refute c.save, "#{c.errors.full_messages.to_sentence}"
    end
    c.data = 'asd'
    assert_no_difference 'Container.count' do
      refute c.save, "#{c.errors.full_messages.to_sentence}"
    end

    c.position = nil
    assert_no_difference 'Container.count' do
      refute c.save, "#{c.errors.full_messages.to_sentence}"
    end

    c.position = 0
    assert_no_difference 'Container.count' do
      refute c.save, "#{c.errors.full_messages.to_sentence}"
    end

    c.name = 'qwe'
    assert_difference 'Container.count', 1 do
      assert c.save, "#{c.errors.full_messages.to_sentence}"
    end
  end

  def test_protected_attrs
    assert_no_difference 'Container.count' do
      assert_raises(ActiveModel::MassAssignmentSecurity::Error) {Container.new(:name => 'asd', :image_file_name => 'asd.png')}
    end

    assert_no_difference 'Container.count' do
      assert_raises(ActiveModel::MassAssignmentSecurity::Error) {Container.new(:name => 'asd', :image_content_type => 'text/html')}
    end

    assert_no_difference 'Container.count' do
      assert_raises(ActiveModel::MassAssignmentSecurity::Error) {Container.new(:name => 'asd', :image_file_size => 123)}
    end
  end

  def test_unique_attrs
    assert_difference 'Container.count', 1 do
      c = Container.new :name => 'unique test'
      assert c.save
    end
    assert_no_difference 'Container.count' do
      c = Container.new :name => 'unique test'
      refute c.save
    end
  end

  protected
  def create_container(options = {})
    record = Container.new({ :name => 'asdzxc234olk', :data => 'test'}.merge(options))
    record.save
    record
  end

end
