require 'test_helper'

class MembershipRankingComponentTest < ViewComponent::TestCase
  test '#render' do
    in_game_1 do
      team = teams(:campeones)
      user = users(:diego)
      component = MembershipRankingComponent.new(team: team, user: user)

      render_inline(component)
      assert_selector 'h2', text: 'Your ranking in this team'
      assert_selector '.points', text: '152', exact_text: true
      assert_selector '.ranking-position', text: '1', exact_text: true
    end
  end

  test 'not #render, no membership' do
    in_game_1 do
      team = teams(:campeones)
      user = users(:zinedine)
      assert_not MembershipRankingComponent.new(team: team, user: user).render?
    end
  end

  test 'not #render, not ranked' do
    in_game_1 do
      team = teams(:campeones)
      user = users(:diego)
      team.memberships.update_all(ranking_position: nil)
      assert_not MembershipRankingComponent.new(team: team, user: user).render?
    end
  end

  test 'not #render, before tournament' do
    before_tournament do
      team = teams(:campeones)
      user = users(:diego)
      assert_not MembershipRankingComponent.new(team: team, user: user).render?, 'should not render before tournament'
    end
  end
end
