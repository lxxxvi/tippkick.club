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

  test 'should redirect to games path after last kickoff' do
    after_kickoff_of_game_51 do
      sign_in_as :diego
      get bets_path
      assert_redirected_to games_path
      follow_redirect!
      assert_response :success
    end
  end
end
