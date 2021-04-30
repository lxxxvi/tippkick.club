require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'show past games' do
    before_game_25 do
      sign_in_as :diego
      navigate_to 'Tournament'
      assert_link 'Dashboard', href: '/dashboard'
      assert_selector '.bet-with-game', count: 24
    end
  end

  test 'shows a past games stats' do
    in_game_25 do
      using_browser do
        sign_in_as :diego
        navigate_to 'Tournament'

        within('#bet-with-game-25') do
          assert_selector 'h3', text: 'BETS BY OUTCOME', count: 0
          assert_selector 'h3', text: 'BETS BY SCORES', count: 0
          click_button
          assert_selector 'h3', text: 'BETS BY OUTCOME'
          assert_selector 'h3', text: 'BETS BY SCORES'
          assert_selector '.bets-stat', count: 2
        end
      end
    end
  end
end
