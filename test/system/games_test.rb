require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'show upcoming and past games' do
    travel_to '2021-06-20 15:00:00 UTC' do
      visit games_path
      assert_selector 'h1', text: 'Games'
      assert_selector '.prediction-with-game', count: 24
    end
  end

  test 'final whistle' do
    skip

    travel_to '2021-06-20 16:00:01 UTC' do
      using_browser do
        visit games_path

        within('.game-card.live-game', match: :first) do
          assert_selector 'button', count: 5
          click_on 'Final Whistle Button'
          assert_selector 'button', count: 0
        end
      end
    end
  end

  test 'undo final whistle' do
    skip

    travel_to '2021-06-20 16:00:01 UTC' do
      using_browser do
        visit games_path
        filter_games 'Past'

        within('.game-card', match: :first) do
          assert_selector 'button', count: 0
          click_on 'Undo Final Whistle'
          assert_selector 'button', count: 5
        end
      end
    end
  end
end
