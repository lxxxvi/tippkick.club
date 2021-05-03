require 'application_system_test_case'

class BetsTest < ApplicationSystemTestCase
  include ActionView::RecordIdentifier

  test 'index shows upcoming games' do
    bet = bets(:diego_game_25)

    before_game_25 do
      sign_in_as :diego
      navigate_to 'Tournament'
      assert_link 'Dashboard', href: '/dashboard'
      within('nav.tournament-navigation') { click_on 'Bets' }
      assert_selector '.bet', count: 27
      assert_selector "##{dom_id(bet)}"
    end
  end

  test 'odds are shown on index' do
    bet = bets(:diego_game_25)

    before_game_25 do
      sign_in_as :diego
      navigate_to 'Tournament'
      within('nav.tournament-navigation') { click_on 'Bets' }

      within("##{dom_id(bet)}") do
        assert_odds(33, 67, 0)
      end
    end
  end

  test 'index does not show kicked-off games' do
    bet = bets(:diego_game_25)

    at_kickoff_of_game_25 do
      sign_in_as :diego
      navigate_to 'Tournament'
      assert_link 'Dashboard', href: '/dashboard'
      within('nav.tournament-navigation') { click_on 'Bets' }
      assert_selector '.bet', count: 25
      assert_selector "##{dom_id(bet)}", count: 0
    end
  end

  test 'predict game' do
    bet = bets(:diego_game_25)
    reset_bet(bet)

    before_game_25 do
      using_browser do
        sign_in_as :diego

        navigate_to 'Tournament'
        within('nav.tournament-navigation') { click_on 'Bets' }

        within("##{dom_id(bet)}") do
          sleep 0.2
          click_on 'Bet now'
          assert_scores(0, 0)
          assert_odds(33, 33, 33)

          increase_home_score
          assert_scores(1, 0)
          assert_odds(67, 33, 0)

          decrease_home_score
          assert_scores(0, 0)

          within('.bet--score-controls--home-team') do
            find_button('-', disabled: true)
          end

          within('.bet--score-controls--guest-team') do
            find_button('-', disabled: true)
          end

          increase_guest_score
          increase_guest_score
          assert_scores(0, 2)
          assert_odds(33, 67, 0)

          decrease_guest_score
          assert_scores(0, 1)
        end
      end
    end
  end

  test 'games not having team names cannot be bet on' do
    bet = bets(:diego_game_37)

    before_tournament do
      sign_in_as :diego

      navigate_to 'Tournament'

      within("##{dom_id(bet)}") do
        assert_selector 'button, a, submit', count: 0
      end
    end
  end

  private

  def increase_home_score
    within('.bet--score-controls--home-team') { click_on '+' }
  end

  def decrease_home_score
    within('.bet--score-controls--home-team') { click_on '-' }
  end

  def increase_guest_score
    within('.bet--score-controls--guest-team') { click_on '+' }
  end

  def decrease_guest_score
    within('.bet--score-controls--guest-team') { click_on '-' }
  end

  def assert_scores(expected_home_team_score, expected_guest_team_score)
    assert_selector '.bet--home-team-score', text: expected_home_team_score.to_s, wait: 4
    assert_selector '.bet--guest-team-score', text: expected_guest_team_score.to_s, wait: 4
  end

  def assert_odds(home, guest, draw)
    assert_selector '.bet-odds--home-team-win-percentage', text: "#{home}%"
    assert_selector '.bet-odds--guest-team-win-percentage', text: "#{guest}%"
    assert_selector '.bet-odds--draw-percentage', text: "#{draw}%"
  end
end
