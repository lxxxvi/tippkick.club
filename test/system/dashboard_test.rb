require 'application_system_test_case'

class DashboardTest < ApplicationSystemTestCase
  test 'displays stats' do
    PredictionPointsService.new.call!

    before_game_25 do
      sign_in_as :diego

      assert_selector 'h1', text: 'Dashboard'

      within 'section#stats' do
        assert_selector '.stats--total-points', text: '152'
        assert_selector '.stats--global-ranking-position', text: '9'
      end
    end
  end

  test 'displays no notification about unpredicted games' do
    Prediction.unpredicted_predictable
              .update_all(home_team_score: 8, guest_team_score: 9)

    before_game_25 do
      sign_in_as :diego
      visit dashboard_path
      assert_selector 'section#unpredicted-predictable-games', count: 0
    end
  end

  test 'displays notification about unpredicted predictable games' do
    before_game_25 do
      sign_in_as :diego

      visit dashboard_path

      within 'section#unpredicted-predictable-games' do
        assert_text 'There are 10 games ready to be predicted'
        click_on '10 games'
      end

      assert_selector 'h1', text: 'Predictions'
    end
  end

  test 'displays teams' do
    before_tournament do
      sign_in_as :diego

      visit dashboard_path

      within 'section#teams' do
        assert_selector '.team', text: 'Campeones'
        assert_selector '.create-team', text: 'Create Team'
      end
    end
  end
end
