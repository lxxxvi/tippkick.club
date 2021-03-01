require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'show games' do
    visit games_path
    assert_selector 'h1', text: 'Games'
    assert_selector '.game-card', count: 51
  end

  test 'change games score' do
    travel_to '2021-06-20 16:00:01 UTC' do
      Capybara.using_driver(:selenium_headless) do
        visit games_path
        assert_selector '.game-card--live', count: 2
      end
    end
  end
end
