class PredictionsController < ApplicationController
  def index
    @predictions = Current.user.predictions.with_game
  end
end
