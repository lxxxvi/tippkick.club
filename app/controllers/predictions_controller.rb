class PredictionsController < ApplicationController
  def index
    @predictions = Current.user.predictions
                          .with_game
                          .kickoff_future
                          .ordered_chronologically
  end
end
