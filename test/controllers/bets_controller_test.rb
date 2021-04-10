require 'test_helper'

class BetsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    before_game_25 do
      sign_in_as :diego
      get bets_path
      assert_response :success
      assert_select '.bet', count: 27
    end
  end
end
