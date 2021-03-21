require 'test_helper'

class DashboardPredictionsComponentTest < ViewComponent::TestCase
  test '.render' do
    before_tournament do
      dashboard = DashboardService.new(users(:diego))
      component = DashboardPredictionsComponent.new(dashboard: dashboard)
      render_inline(component)
      assert_selector '.unpredicted-predictable-games',
                      text: 'There are 10 games ready to be predicted',
                      normalize_ws: true
    end
  end
end
