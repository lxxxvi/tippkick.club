class PredictionsController < ApplicationController
  def index
    @predictions = current_user.predictions
                               .with_game
                               .kickoff_future
                               .ordered_chronologically
  end
end
