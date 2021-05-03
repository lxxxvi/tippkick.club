require 'test_helper'

class BetOddsComponentTest < ViewComponent::TestCase
  test '#render' do
    game = games(:game_2)
    component = BetOddsComponent.new(game: game)
    render_inline(component)
    assert_text '33%'
    assert_text '67%'

    assert_in_delta component.bets_home_team_wins_percentage, 33.3, 0.1
    assert_equal 0.0, component.bets_guest_team_wins_percentage
    assert_in_delta component.bets_draw_percentage, 66.66, 0.1
  end

  test '#render, not if there are no bets' do
    game = games(:game_37) # teams or not set for game_37, thus there are not bets
    component = BetOddsComponent.new(game: game)
    render_inline(component)
    assert_text ''
  end
end
