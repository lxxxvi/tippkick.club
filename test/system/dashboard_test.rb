require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
  test 'dashbor' do
    PredictionPointsService.new.call!

    before_game_25 do
      sign_in_as :diego

      assert_selector 'h1', text: 'Dashboard'
      assert_text 'There are 10 games ready to be predicted'
      assert_text 'You are at position 1 in the global ranking'
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
