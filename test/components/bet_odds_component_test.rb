require 'test_helper'

class BetOddsComponentTest < ViewComponent::TestCase
  test '#render' do
    game = games(:game_2)

    before_tournament do
      component = BetOddsComponent.new(game: game)
      render_inline(component)
      assert_selector '.bet-odds'
      assert_text '33%'
      assert_text '67%'

      assert_in_delta component.bets_home_team_wins_percentage, 33.3, 0.1
      assert_equal 0.0, component.bets_guest_team_wins_percentage
      assert_in_delta component.bets_draw_percentage, 66.66, 0.1
    end
  end

  test '#render, not if there are no bets' do
    game = games(:game_37) # teams or not set for game_37, thus there are not bets
    component = BetOddsComponent.new(game: game)
    render_inline(component)
    assert_text ''
  end

  test '#render, not if game is after round_of_16 and kickoff is in future' do
    game = games(:game_45)
    game.update_columns(bets_home_team_wins_count: 1, bets_guest_team_wins_count: 2, bets_draw_count: 4)

    before_game_45 do
      component = BetOddsComponent.new(game: game)
      render_inline(component)
      assert_selector '.bet-odds', count: 0
      assert_text 'After Round of 16, the odds are displayed just after kickoff.'
    end
  end

  test '#render if game is after round_of_16 and kickoff is in past' do
    game = games(:game_45)
    game.update_columns(bets_home_team_wins_count: 1, bets_guest_team_wins_count: 2, bets_draw_count: 4)

    in_game_45 do
      component = BetOddsComponent.new(game: game)
      render_inline(component)
      assert_selector '.bet-odds', count: 1
    end
  end
end
