class TeamDecorator < SimpleDelegator
  include Rails.application.routes.url_helpers

  def invitation_link
    join_team_url(self, invitation_token)
  end
end
