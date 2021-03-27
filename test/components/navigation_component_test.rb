require 'test_helper'

class NavigationComponentTest < ViewComponent::TestCase
  test '.render, not signed_in' do
    component = NavigationComponent.new(signed_in: false)
    render_inline component
    assert_link 'Sign In'
    assert_no_link 'Dashboard'
    assert_no_link 'Prediction'
    assert_no_link 'Games'
  end

  test '.render, signed_in' do
    component = NavigationComponent.new(signed_in: true)
    render_inline component
    assert_no_link 'Sign In'
    assert_link 'Dashboard'
    assert_link 'Prediction'
    assert_link 'Games'
  end
end
