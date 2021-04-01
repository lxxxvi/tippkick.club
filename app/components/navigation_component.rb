class NavigationComponent < ViewComponent::Base
  def initialize(signed_in:)
    @signed_in = signed_in
  end

  def signed_in?
    @signed_in
  end

  def predictions_or_games_path
    return predictions_path if Tournament.before_first_kickoff?

    games_path
  end
end
