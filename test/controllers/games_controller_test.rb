require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    before_game_25 do
      sign_in_as :diego
      get games_path
      assert_response :success
      assert_select '.bet-with-game', count: 24
    end
  end
end
