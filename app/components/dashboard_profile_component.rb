class DashboardProfileComponent < ViewComponent::Base
  def render?
    Tournament.before_last_kickoff?
  end
end
