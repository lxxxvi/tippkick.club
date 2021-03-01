class GameScoresReflex < ApplicationReflex
  def increment
    update_game(+1)
    morph dom_id(find_game), render(partial: 'games/game_card', locals: { game: find_game.reload })
  end

  def decrement
    update_game(-1)
    morph dom_id(find_game), render(partial: 'games/game_card', locals: { game: find_game.reload })
  end

  private

  def find_game
    @find_game ||= Game.find(element.dataset[:id])
  end

  def update_game(delta)
    find_game.tap do |game|
      current_score = game[team_score_attribute]
      new_score = [[team_score_attribute, current_score + delta]].to_h
      game.update(new_score)
    end
  end

  def team_score_attribute
    {
      home: :home_team_score,
      guest: :guest_team_score
    }[element.dataset[:team_score].to_sym]
  end
end
