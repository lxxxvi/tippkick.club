require 'test_helper'

class DashboardBetsComponentTest < ViewComponent::TestCase
  test '.render' do
    before_tournament do
      component = DashboardBetsComponent.new(users(:diego))
      render_inline(component)
      assert_text 'There are 10 games ready to bet', normalize_ws: true
    end
  end
end
