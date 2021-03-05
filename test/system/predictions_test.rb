require 'application_system_test_case'

class PredictionsTest < ApplicationSystemTestCase
  test 'show upcaming and past games' do
    visit predictions_path
    assert_selector 'h1', text: 'Predictions'
    assert_selector '.prediction', count: 51
  end
end
