require 'test_helper'

class TeamMembershipsComponentTest < ViewComponent::TestCase
  test '.render' do
    component = TeamMembershipsComponent.new(team: teams(:global), params: {})
    render_inline(component)
    assert_selector 'nav.pagination', count: 0
    assert_selector '.team-memberships'
  end

  test '.render with pagination' do
    default_items = Pagy::VARS[:items]
    Pagy::VARS[:items] = 2
    component = TeamMembershipsComponent.new(team: teams(:global), params: {})
    render_inline(component)
    assert_selector 'nav.pagination', count: 1
  ensure
    Pagy::VARS[:items] = default_items
  end
end
