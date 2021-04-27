require 'test_helper'

class BetsStatComponentTest < ViewComponent::TestCase
  test '#render' do
    bets_stat = bets_stats(:game_1_0_0)
    component = BetsStatComponent.new(bets_stat: bets_stat, bets_count: 4)
    assert_equal 25, component.bet_percentage

    render_inline(component)

    assert_text '0:0'
    assert_text '25%'
  end
end
