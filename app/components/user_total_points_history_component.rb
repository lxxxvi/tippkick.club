class UserTotalPointsHistoryComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  def users_bets_with_games
    @users_bets_with_games ||= @user.bets.with_game.of_ended_games.ordered_antichronologically
  end
end
