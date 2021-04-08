require 'test_helper'

class InvitationLinkComponentTest < ViewComponent::TestCase
  test '.render' do
    component = InvitationLinkComponent.new(
      team: teams(:campeones),
      user: users(:diego)
    )

    render_inline(component)
    assert_selector 'label', text: 'Invitation Link'
    assert_selector 'button', text: 'Copy'
    assert_field 'Invitation Link',
                 with: 'http://tippkick.test/teams/tkid_campeones/join/campeones_token'
  end

  test '#render, not if not authorized' do
    assert_not InvitationLinkComponent.new(team: teams(:campeones),
                                           user: users(:pele)).render?
  end
end
