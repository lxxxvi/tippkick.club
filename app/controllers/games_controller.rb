class GamesController < ApplicationController
  def index
    @predictions_with_game = current_user.predictions
                                         .with_game
                                         .kickoff_past
                                         .ordered_antichronologically
  end
end
