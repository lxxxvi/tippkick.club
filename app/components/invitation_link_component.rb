class InvitationLinkComponent < ViewComponent::Base
  def initialize(invitation_link:)
    @invitation_link = invitation_link
  end
end
