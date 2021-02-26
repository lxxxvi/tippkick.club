class ScoresReflex < ApplicationReflex
  def increment
    update_entity(+1)
    morph dom_id(find_entity), render(partial: 'games/form', locals: { game: find_entity.reload })
  end

  def decrement
    update_entity(-1)
  end

  private

  def find_entity
    @find_entity ||= entity_klass.find(element.dataset[:id])
  end

  def entity_klass
    {
      game: Game,
      prediction: Prediction
    }[element.dataset[:entity].to_sym]
  end

  def update_entity(delta)
    find_entity.tap do |entity|
      current_score = entity[team_score_attribute]
      new_score = Hash[team_score_attribute, current_score + delta]
      entity.update(new_score)
    end
  end

  def team_score_attribute
    {
      home: :home_team_score,
      guest: :guest_team_score
    }[element.dataset[:team_score].to_sym]
  end
end
