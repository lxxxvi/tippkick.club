require 'test_helper'

class LandingPageComponentTest < ViewComponent::TestCase
  test '#render' do
    render_inline LandingPageComponent.new
    assert_selector 'h1', text: 'We are back!'
  end
end
