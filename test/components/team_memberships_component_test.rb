require 'test_helper'

class TeamMembershipsComponentTest < ViewComponent::TestCase
  test '.render' do
    component = TeamMembershipsComponent.new(team: teams(:global), params: {}, user: users(:diego))
    render_inline(component)
    assert_selector 'nav.pagination', count: 0
    assert_selector 'table.team-memberships'
  end

  test '.render with pagination' do
    default_items = Pagy::VARS[:items]
    Pagy::VARS[:items] = 2
    component = TeamMembershipsComponent.new(team: teams(:global), params: {}, user: users(:diego))
    render_inline(component)
    assert_selector 'nav.pagination', count: 1
  ensure
    Pagy::VARS[:items] = default_items
  end

  test '.render, columns before tournament' do
    before_tournament do
      component = TeamMembershipsComponent.new(team: teams(:global), params: {}, user: users(:diego))
      render_inline(component)
      assert_selector 'th', count: 1
    end
  end

  test '.render, in game 1' do
    in_game_1 do
      component = TeamMembershipsComponent.new(team: teams(:global), params: {}, user: users(:diego))
      render_inline(component)
      assert_selector 'th', count: 3
    end
  end
end
