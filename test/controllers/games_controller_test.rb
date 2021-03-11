require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    travel_to '2021-06-20 14:00:00 UTC' do
      get games_path
      assert_response :success
      assert_select '.prediction-with-game', count: 24
    end
  end
end
