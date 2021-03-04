class GamesController < ApplicationController
  helper_method :filter_on_past?

  def index
    @games = filtered_games
  end

  private

  def filtered_games
    return ordered_games.past if filter_on_past?

    ordered_games.upcoming
  end

  def ordered_games
    @ordered_games ||= Game.ordered_chronologically
  end

  def filter_on_past?
    params[:filter]&.casecmp?('past')
  end
end
