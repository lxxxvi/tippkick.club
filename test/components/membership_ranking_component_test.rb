require 'test_helper'

class MembershipRankingComponentTest < ViewComponent::TestCase
  test '#render' do
    team = teams(:campeones)
    user = users(:diego)
    component = MembershipRankingComponent.new(team: team, user: user)

    render_inline(component)
    assert_selector 'h2', text: 'Your Ranking In This Team'
    assert_selector '.points', text: '152', exact_text: true
    assert_selector '.ranking-position', text: '1', exact_text: true
  end

  test 'not #render, no membership' do
    team = teams(:campeones)
    user = users(:zinedine)
    assert_not MembershipRankingComponent.new(team: team, user: user).render?
  end

  test 'not #render, not ranked' do
    team = teams(:campeones)
    user = users(:diego)
    team.memberships.update_all(ranking_position: nil)
    assert_not MembershipRankingComponent.new(team: team, user: user).render?
  end
end
