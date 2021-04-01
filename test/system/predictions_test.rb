require 'application_system_test_case'

class PredictionsTest < ApplicationSystemTestCase
  include ActionView::RecordIdentifier

  test 'index shows upcoming games' do
    prediction = predictions(:diego_game_25)

    before_game_25 do
      sign_in_as :diego
      navigate_to 'Tournament'
      within('nav.tournament-navigation') { click_on 'Predictions' }
      assert_selector '.prediction', count: 27
      assert_selector "##{dom_id(prediction)}"
    end
  end

  test 'index does not show kicked-off games' do
    prediction = predictions(:diego_game_25)

    at_kickoff_of_game_25 do
      sign_in_as :diego
      navigate_to 'Tournament'
      within('nav.tournament-navigation') { click_on 'Predictions' }
      assert_selector '.prediction', count: 25
      assert_selector "##{dom_id(prediction)}", count: 0
    end
  end

  test 'predict game' do
    prediction = predictions(:diego_game_25)
    reset_prediction(prediction)

    before_game_25 do
      using_browser do
        sign_in_as :diego

        navigate_to 'Tournament'
        within('nav.tournament-navigation') { click_on 'Predictions' }

        within("##{dom_id(prediction)}") do
          sleep 0.2
          click_on 'Start'
          assert_scores(0, 0)

          increase_home_score
          assert_scores(1, 0)

          decrease_home_score
          assert_scores(0, 0)

          within('.prediction--score-controls--home-team') do
            find_button('-', disabled: true)
          end

          within('.prediction--score-controls--guest-team') do
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

  test 'games not having team names cannot be predicted' do
    prediction = predictions(:diego_game_37)

    before_tournament do
      sign_in_as :diego

      navigate_to 'Tournament'

      within("##{dom_id(prediction)}") do
        assert_selector 'button, a, submit', count: 0
      end
    end
  end

  private

  def increase_home_score
    within('.prediction--score-controls--home-team') { click_on '+' }
  end

  def decrease_home_score
    within('.prediction--score-controls--home-team') { click_on '-' }
  end

  def increase_guest_score
    within('.prediction--score-controls--guest-team') { click_on '+' }
  end

  def decrease_guest_score
    within('.prediction--score-controls--guest-team') { click_on '-' }
  end

  def assert_scores(expected_home_team_score, expected_guest_team_score)
    assert_selector '.prediction--home-team-score', text: expected_home_team_score.to_s, wait: 4
    assert_selector '.prediction--guest-team-score', text: expected_guest_team_score.to_s, wait: 4
  end
end
