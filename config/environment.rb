# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
RubyTest::Application.initialize!

JOB_STATUSES = {
    :new => 'NEW',
    :in_progress => 'IN_PROGRESS',
    :error => 'ERROR',
    :ok => 'OK'
}
