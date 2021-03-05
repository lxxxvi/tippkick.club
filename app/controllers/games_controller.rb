class GamesController < ApplicationController
  def index
    @predictions_with_game = Current.user.predictions
                                    .with_game
                                    .kickoff_past
                                    .ordered_antichronologically
  end
end
