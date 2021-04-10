class BetsController < ApplicationController
  def index
    @bets = current_user.bets
                        .with_game
                        .kickoff_future
                        .ordered_chronologically
  end
end
