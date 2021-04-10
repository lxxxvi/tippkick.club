require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'show upcoming and past games' do
    before_game_25 do
      sign_in_as :diego
      navigate_to 'Tournament'
      assert_link 'Dashboard', href: '/dashboard'
      assert_selector '.bet-with-game', count: 24
    end
  end
end
