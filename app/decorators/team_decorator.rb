class TeamDecorator < SimpleDelegator
  include Rails.application.routes.url_helpers

  def invitation_link
    join_team_url(id: special_id_for_join_link, token: invitation_token)
  end

  private

  def special_id_for_join_link
    "#{to_param}-#{name.parameterize}"
  end
end
