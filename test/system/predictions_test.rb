require 'application_system_test_case'

class PredictionsTest < ApplicationSystemTestCase
  include ActionView::RecordIdentifier

  test 'index shows upcoming games' do
    prediction = predictions(:diego_game_25)

    travel_to '2021-06-20 15:00:00 UTC' do
      sign_in_as :diego
      navigate_to 'Predictions'
      assert_selector 'h1', text: 'Predictions'
      assert_selector '.prediction', count: 27
      assert_selector "##{dom_id(prediction)}"
    end
  end

  test 'index does not show kicked-off games' do
    prediction = predictions(:diego_game_25)

    travel_to '2021-06-20 16:00:00 UTC' do
      sign_in_as :diego
      navigate_to 'Predictions'
      assert_selector 'h1', text: 'Predictions'
      assert_selector '.prediction', count: 25
      assert_selector "##{dom_id(prediction)}", count: 0
    end
  end

  test 'predict game' do
    prediction = predictions(:diego_game_25)
    prediction.update(home_team_score: nil, guest_team_score: nil)

    travel_to '2021-06-20 15:00:00 UTC' do
      using_browser do
        sign_in_as :diego
        navigate_to 'Predictions'

        within("##{dom_id(prediction)}") do
          click_on 'Start'
          assert_scores(0, 0)

          increase_home_score
          assert_scores(1, 0)

          decrease_home_score
          assert_scores(0, 0)

          within('.prediction--score-controls--home-minus') do
            find_button('-', disabled: true)
          end

          within('.prediction--score-controls--guest-minus') do
            find_button('-', disabled: true)
          end

          increase_guest_score
          increase_guest_score
          assert_scores(0, 2)

          decrease_guest_score
          assert_scores(0, 1)
        end
      end
    end
  end

  private

  def increase_home_score
    within('.prediction--score-controls--home-plus') { click_on '+' }
  end

  def decrease_home_score
    within('.prediction--score-controls--home-minus') { click_on '-' }
  end

  def increase_guest_score
    within('.prediction--score-controls--guest-plus') { click_on '+' }
  end

  def decrease_guest_score
    within('.prediction--score-controls--guest-minus') { click_on '-' }
  end

  def assert_scores(expected_home_team_score, expected_guest_team_score)
    assert_selector '.prediction--home-team-score', text: expected_home_team_score.to_s
    assert_selector '.prediction--guest-team-score', text: expected_guest_team_score.to_s
  end
end
