require 'test_helper'

class PredictionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get predictions_path
    assert_response :success
    assert_select '.predictions', count: 51
  end
end
