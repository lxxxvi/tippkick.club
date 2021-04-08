class InvitationLinkReflex < ApplicationReflex
  def refresh
    team.refresh_invitation_token!
    morph '#invitation-link', render(InvitationLinkComponent.new(team: team, user: current_user), layout: false)
  end

  private

  def team
    @team ||= found_team_or_new
  end

  def found_team_or_new
    TeamPolicy.new(find_team, user: current_user).invite? ? find_team : Team.new
  end

  def find_team
    @find_team ||= Team.find_by!(tippkick_id: element.dataset.team_tippkick_id)
  end
end
