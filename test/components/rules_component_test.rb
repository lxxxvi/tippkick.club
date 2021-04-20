require 'test_helper'

class RulesComponentTest < ViewComponent::TestCase
  test '#render' do
    render_inline RulesComponent.new
    assert_selector 'li', text: 'Betting rules'
    assert_selector 'li', text: 'Award for points'
    assert_selector 'li', text: 'Example'
  end
end
