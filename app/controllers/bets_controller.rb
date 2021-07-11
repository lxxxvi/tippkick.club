class BetsController < ApplicationController
  def index
    redirect_to games_path if Tournament.after_last_kickoff?

    @bets = current_user.bets
                        .with_game
                        .kickoff_future
                        .ordered_chronologically
  end
end
