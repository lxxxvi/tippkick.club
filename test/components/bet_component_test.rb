require 'test_helper'

class BetComponentTest < ViewComponent::TestCase
  test 'past game doesnt render' do
    bet = bets(:diego_game_1)

    before_game_25 do
      component = BetComponent.new(bet: bet)
      render_inline(component)
      assert page.text.empty?, 'should not have rendered'
    end
  end

  test '.render, bet_pending game' do
    bet = bets(:diego_game_27)

    before_game_25 do
      component = BetComponent.new(bet: bet)
      render_inline(component)
      assert_selector 'button', text: 'Bet now'
    end
  end

  test '.render, bet_complete game' do
    bet = bets(:diego_game_1)

    before_tournament do
      component = BetComponent.new(bet: bet)
      render_inline(component)
      assert_selector 'button', text: '+', count: 2
      assert_selector 'button', text: '-', count: 2
    end
  end
end
