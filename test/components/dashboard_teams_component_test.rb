require 'test_helper'

class DashboardTeamsComponentTest < ViewComponent::TestCase
  test '.render' do
    dashboard = DashboardService.new(users(:diego))
    component = DashboardTeamsComponent.new(dashboard: dashboard)
    render_inline(component)
    assert_selector '.teams .team', minimum: 1
    assert_selector '.teams .create-team', count: 1
  end
end
