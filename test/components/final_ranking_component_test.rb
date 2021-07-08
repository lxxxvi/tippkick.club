require 'test_helper'

class FinalRankingComponentTest < ViewComponent::TestCase
  test '.render, one winner' do
    end_tournament!

    component = FinalRankingComponent.new(users(:diego))
    render_inline component

    assert_equal 1, component.global_winners.count
    assert_includes component.global_winners, users(:diego)

    assert_text 'Your final global ranking'
    assert_selector '.global-ranking', text: '1'

    assert_text 'Congratulations to our global winner'
    assert_selector 'li', count: 1
    assert_selector 'li', text: 'digi'
    assert_text 'They deserve to be addressed with FUSSBALLÜBERGOTT from now on.'

    assert_link 'Global ranking', href: '/teams/global'
  end

  test '.render, multiple winners' do
    end_tournament!

    memberships(:zinedine_global).update_column(:ranking_position, 1)

    component = FinalRankingComponent.new(users(:diego))
    render_inline component

    assert_equal 2, component.global_winners.count
    assert_includes component.global_winners, users(:diego)
    assert_includes component.global_winners, users(:zinedine)

    assert_text 'Congratulations to our global winners'
    assert_selector 'li', count: 2
    assert_selector 'li', text: 'digi'
    assert_selector 'li', text: 'zinedine'
  end
end
