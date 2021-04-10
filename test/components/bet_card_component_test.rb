require 'test_helper'

class BetCardComponentTest < ViewComponent::TestCase
  test '.render' do
    render_inline(
      BetCardComponent.new(
        border_color_class: 'border-kolor',
        bg_color_class: 'bg-kolor'
      )
    ) do |component|
      component.header { 'HEADER' }
      component.body { 'BODY' }
      component.footer { 'FOOTER' }
    end

    assert_selector '.border-kolor', count: 3
    assert_selector '.bg-kolor', count: 1
  end
end
