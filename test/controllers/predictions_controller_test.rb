require 'test_helper'

class PredictionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    travel_to '2021-06-20 13:00:00 UTC' do
      sign_in_as :diego
      get predictions_path
      assert_response :success
      assert_select '.prediction', count: 27
    end
  end
end
