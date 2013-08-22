require 'test_helper'

class ContainersControllerTest < ActionController::TestCase
  test 'should get edit' do
    get :edit
    assert (@response.success? or @response.redirect?), 'Not success or redirect'
  end

end
