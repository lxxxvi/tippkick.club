class DashboardTeamsComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def stats_ready?
    total_points.present?
  end

  def total_points
    @total_points ||= @user.total_points
  end
end
