require 'application_system_test_case'

class TournamentsTest < ApplicationSystemTestCase
  test 'before tournament' do
    before_tournament do
      sign_in_as :diego
      navigate_to 'Tournament'

      assert_selector tournament_navigation_selector, count: 0
      assert_selector '.bet'
    end
  end

  test 'during tournament' do
    before_game_25 do
      sign_in_as :diego
      navigate_to 'Tournament'

      within(tournament_navigation_selector) do
        assert_selector 'span', text: 'Games'
        assert_link 'Bets', href: '/tournament/bets'
        click_on 'Bets'
      end

      within(tournament_navigation_selector) do
        assert_link 'Games', href: '/tournament/games'
        assert_selector 'span', text: 'Bets'
        click_on 'Games'
      end
    end
  end

  test 'after tournament' do
    after_tournament do
      sign_in_as :diego
      navigate_to 'Tournament'

      assert_selector tournament_navigation_selector, count: 0
      assert_selector '.bet-with-game'
    end
  end

  private

  def tournament_navigation_selector
    'nav.tournament-navigation'
  end
end
