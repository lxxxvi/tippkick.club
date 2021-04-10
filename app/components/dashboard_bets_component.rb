class DashboardBetsComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def all_set?
    bet_pending_and_ready_games_count.zero?
  end

  def bet_pending_and_ready_games_count
    @bet_pending_and_ready_games_count ||= @user.bets.bet_pending_and_ready.count
  end
end
