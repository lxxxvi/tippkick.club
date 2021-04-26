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
          assert_selector 'h3', text: 'Popular bets', count: 0
          click_on 'button[aria-controls=game-stats]'
          assert_selector 'h3', text: 'Popular bets'
        end
      end
    end
  end
end
