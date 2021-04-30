require 'test_helper'

class BetsStatsComponentTest < ViewComponent::TestCase
  test '#render' do
    game = games(:game_1)

    component = BetsStatsComponent.new(game: game)
    render_inline(component)

    assert_selector '.bets-stats', count: 1
    assert_selector '.bets-stat', count: 3
  end
end
