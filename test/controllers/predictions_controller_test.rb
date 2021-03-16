require 'test_helper'

class PredictionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    before_game_25 do
      sign_in_as :diego
      get predictions_path
      assert_response :success
      assert_select '.prediction', count: 27
    end
  end
end
