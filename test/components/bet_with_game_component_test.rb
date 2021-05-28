require 'test_helper'

class BetWithGameComponentTest < ViewComponent::TestCase
  test '#render, not render before game' do
    before_game_25 do
      bet = bets(:diego_game_25)
      render_inline BetWithGameComponent.new(bet_with_game: bet)
      assert_equal '', page.text
    end
  end

  test '#render, in game' do
    in_game_25 do
      bet = bets(:diego_game_25)
      component = BetWithGameComponent.new(bet_with_game: bet)
      render_inline component
      assert_text 'LIVE'
    end
  end

  test '#render, after game' do
    after_game_25 do
      games(:game_25).tap do |game|
        game.assign_attributes(home_team_score: 0, guest_team_score: 0)
        game.final_whistle
      end

      bet = bets(:diego_game_25)
      component = BetWithGameComponent.new(bet_with_game: bet)
      render_inline component
      assert_no_text 'LIVE'
      assert_text 'You scored 0 points'
    end
  end
end
