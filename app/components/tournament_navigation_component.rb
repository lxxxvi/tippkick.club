class TournamentNavigationComponent < ViewComponent::Base
  def render?
    Tournament.tournament_ongoing?
  end
end
