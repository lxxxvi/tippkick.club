require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
  test 'dashboard' do
    PredictionPointsService.new.call!

    before_game_25 do
      sign_in_as :diego

      within('nav') do
        assert_link 'Tournament', href: '/tournament/games', count: 2
        assert_link 'Teams', href: '/teams', count: 2
      end

      assert_selector 'h1', text: 'Dashboard'
      assert_text 'There are 10 games ready to be predicted'
      assert_text 'You are in 2 teams'
      assert_text 'Change Your Profile'
    end
  end

  test 'displays no notification about unpredicted games' do
    Prediction.unpredicted_predictable
              .update_all(home_team_score: 8, guest_team_score: 9)

    before_game_25 do
      sign_in_as :diego
      assert_text 'Youre All Set'
    end
  end
end
