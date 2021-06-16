class UserTotalPointsHistoryReflex < ApplicationReflex
  def display
    morph "#user-#{find_user.id}-total-points-history",
          render(UserTotalPointsHistoryComponent.new(user: find_user), layout: false)
  end

  def find_user
    @find_user ||= User.find(element.dataset[:user_total_points_history_user_id])
  end
end
