require 'test_helper'

class MembershipOfUserComponentTest < ViewComponent::TestCase
  test '.render' do
    component = MembershipOfUserRowComponent.new(
      membership_of_user_row: memberships(:diego_campeones)
    )

    render_inline(component)
    page.all('td').tap do |td|
      assert_equal 'Campeones', td[0].text.strip
      assert_equal '1', td[1].text.strip
      assert_equal '2', td[2].text.strip
    end
  end
end
