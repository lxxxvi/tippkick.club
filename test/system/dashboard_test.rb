require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
  test 'dashboard' do
    BetPointsService.new.call!

    before_game_25 do
      sign_in_as :diego

      within('nav') do
        assert_link 'Tournament', href: '/tournament/games', count: 2
        assert_link 'Teams', href: '/teams', count: 2
      end

      assert_selector 'h1', text: 'Hey digi, this is your dashboard'
      assert_selector 'h2', text: 'Rules'
      assert_text 'There are 10 games ready to bet'
      assert_text 'You are in 2 teams'
      assert_text 'Change your profile'
    end
  end

  test 'displays no notification about bet_pending games' do
    Bet.bet_pending_and_ready
       .update_all(home_team_score: 8, guest_team_score: 9)

    before_game_25 do
      sign_in_as :diego
      assert_text 'You are all set'
    end
  end
end
