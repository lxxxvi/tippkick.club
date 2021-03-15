ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'time_travelers'

class ActiveSupport::TestCase
  include TimeTravelers
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # rubocop:disable Rails/SkipsModelValidations
  def reset_prediction(prediction)
    prediction.update_columns(home_team_score: nil, guest_team_score: nil)
  end
  # rubocop:enable Rails/SkipsModelValidations
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def sign_in_as(fixture_key)
    sign_in users(fixture_key)
  end
end
