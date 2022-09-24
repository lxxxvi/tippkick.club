class InvitationLinkComponent < ViewComponent::Base
  def initialize(team:, user:)
    @team = team
    @user = user
  end

  def render?
    TeamPolicy.new(@team, user: @user).invite?
  end

  def invitation_link
    @team.decorate.invitation_link
  end
end
