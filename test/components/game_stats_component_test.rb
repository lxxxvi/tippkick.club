require 'test_helper'

class GameStatsComponentTest < ViewComponent::TestCase
  test '#render' do
    game = games(:game_1)
    component = GameStatsComponent.new(game: game)
    assert_match /game-[0-9]+-bets-stats/, component.bets_stats_element_id
    render_inline(component)

    assert_selector '.game-stats-content'
    assert_selector '.game-stats-navigation'
  end
end
