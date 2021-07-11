require 'test_helper'

class DashboardBetsComponentTest < ViewComponent::TestCase
  test '.render' do
    before_tournament do
      component = DashboardBetsComponent.new(users(:diego))
      render_inline(component)
      assert_text 'There are 10 games ready to bet', normalize_ws: true
      assert_link 'Bets', href: '/tournament/bets'
    end
  end

  test '.render, after last games kickoff' do
    after_kickoff_of_game_51 do
      component = DashboardBetsComponent.new(users(:diego))
      render_inline(component)
      assert_link 'Games', href: '/tournament/games'
    end
  end
end
