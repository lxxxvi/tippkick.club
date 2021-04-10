class GamesController < ApplicationController
  def index
    @bets_with_game = current_user.bets
                                  .with_game
                                  .kickoff_past
                                  .ordered_antichronologically
  end
end
