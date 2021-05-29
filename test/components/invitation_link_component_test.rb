require 'test_helper'

class InvitationLinkComponentTest < ViewComponent::TestCase
  test '.render' do
    component = InvitationLinkComponent.new(
      team: teams(:campeones),
      user: users(:diego)
    )

    render_inline(component)
    assert_selector 'label', text: 'Invitation link'
    assert_selector 'button[aria-label="Copy"]'
    assert_field 'Invitation link',
                 with: 'http://tippkick.test/teams/tkid_campeones-campeones/join/campeones_token'
  end

  test '#render, not if not authorized' do
    assert_not InvitationLinkComponent.new(team: teams(:campeones),
                                           user: users(:pele)).render?
  end
end
