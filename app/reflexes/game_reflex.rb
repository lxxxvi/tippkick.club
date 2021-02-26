class GameReflex < ApplicationReflex
  def change_score
    update_scores
    update_game_card
  end

  def final_whistle
    update_final_whistle
    update_game_card
  end

  private

  def update_game_card
    morph dom_id(find_game), render(partial: 'games/game_card', locals: { game: find_game.reload })
  end

  def find_game
    @find_game ||= Game.find(element.dataset[:id])
  end

  def update_scores
    find_game.tap do |game|
      current_score = game[team_score_attribute]
      game[team_score_attribute] = current_score + score_delta
      game.save
    end
  end

  def update_final_whistle
    find_game.final_whistle(reset: reset_final_whistle)
  end

  def team_score_attribute
    {
      home: :home_team_score,
      guest: :guest_team_score
    }[element.dataset[:team_score].to_sym]
  end

  def score_delta
    {
      plus: +1,
      minus: -1
    }[element.dataset[:delta].to_sym]
  end

  def reset_final_whistle
    element.dataset[:reset]
  end
end
