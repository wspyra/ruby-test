ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all containers in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration containers
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all containers here...
end
