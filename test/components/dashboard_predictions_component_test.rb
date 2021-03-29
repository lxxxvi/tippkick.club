require 'test_helper'

class DashboardPredictionsComponentTest < ViewComponent::TestCase
  test '.render' do
    before_tournament do
      component = DashboardPredictionsComponent.new(users(:diego))
      render_inline(component)
      assert_text 'There are 10 games ready to be predicted', normalize_ws: true
    end
  end
end
