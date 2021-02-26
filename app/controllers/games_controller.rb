class GamesController < ApplicationController
  def index
    @ordered_games = Game.ordered_chronologically
  end
end
