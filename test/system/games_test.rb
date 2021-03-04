require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'show upcaming and past games' do
    visit games_path
    assert_selector 'h1', text: 'Games'
    assert_selector '.game-card', count: 27

    filter_games 'Past'
    assert_selector '.game-card', count: 24

    filter_games 'Upcoming'
    assert_selector '.game-card', count: 27
  end

  test 'change games score' do
    travel_to '2021-06-20 16:00:01 UTC' do
      using_browser do
        visit games_path
        assert_selector '.game-card.live-game', count: 2

        within('.game-card.live-game', match: :first) do
          # change home team score
          assert_selector '.game-card--home-team-score', text: '1'

          within('.game-card--score-controls--home-plus') { click_on '+' }
          assert_selector '.game-card--home-team-score', text: '2'

          within('.game-card--score-controls--home-minus') do
            click_on '-'
            click_on '-'
          end
          assert_selector '.game-card--home-team-score', text: '0'

          within('.game-card--score-controls--home-minus') do
            find_button('-', disabled: true)
          end

          # change guest team score
          assert_selector '.game-card--guest-team-score', text: '2'

          within('.game-card--score-controls--guest-plus') do
            click_on '+'
            click_on '+'
          end
          assert_selector '.game-card--guest-team-score', text: '4'

          within('.game-card--score-controls--guest-minus') { click_on '-' }
          assert_selector '.game-card--guest-team-score', text: '3'
          within('.game-card--score-controls--guest-minus') { click_on '-' }
          within('.game-card--score-controls--guest-minus') { click_on '-' }
          within('.game-card--score-controls--guest-minus') { click_on '-' }

          assert_selector '.game-card--guest-team-score', text: '0'
          within('.game-card--score-controls--guest-minus') do
            find_button('-', disabled: true)
          end
        end
      end
    end
  end

  test 'final whistle' do
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

  private

  def filter_games(text)
    within('.games-filter-menu') { click_on text }
  end
end
