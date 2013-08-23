require 'test_helper'

class ContainersControllerTest < ActionController::TestCase
  test 'should get edit' do
    1000.times do |n|
      get(:edit, :id => n)
      assert (@response.success? or @response.redirect?), 'Not success or redirect'
    end
  end

  test 'should get new' do
    get :new
    assert @response.success?, 'Not success'
  end
end
