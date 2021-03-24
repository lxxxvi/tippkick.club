require 'test_helper'

class InvitationLinkComponentTest < ViewComponent::TestCase
  test '.render' do
    link = 'https://foo.bar'.freeze
    component = InvitationLinkComponent.new(invitation_link: link)

    render_inline(component)
    assert_selector 'label', text: 'Invitation Link'
    assert_selector 'button', text: 'Copy'
    assert_field 'Invitation Link', with: link
  end
end
