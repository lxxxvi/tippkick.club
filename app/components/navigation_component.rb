class NavigationComponent < ViewComponent::Base
  delegate :admin?, to: :@user

  def initialize(signed_in:, user: nil)
    @signed_in = signed_in
    @user = user || User.new
  end

  def signed_in?
    @signed_in
  end

  def bets_or_games_path
    return bets_path if Tournament.before_first_kickoff?

    games_path
  end
end
