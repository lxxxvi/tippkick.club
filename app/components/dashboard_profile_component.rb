class DashboardProfileComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end
end
