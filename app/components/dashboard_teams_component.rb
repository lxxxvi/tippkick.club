class DashboardTeamsComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def number_of_teams
    @number_of_teams ||= @user.teams.count
  end
end
