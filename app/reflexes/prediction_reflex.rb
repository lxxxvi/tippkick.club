class PredictionReflex < ApplicationReflex
  def change_score
    update_scores
    update_prediction_card
  end

  def start
    find_prediction.home_team_score ||= 0
    find_prediction.guest_team_score ||= 0
    find_prediction.save
    update_prediction_card
  end

  private

  def update_prediction_card
    morph dom_id(find_prediction),
          render(PredictionComponent.new(prediction: find_prediction), layout: false)
  end

  def find_prediction
    @find_prediction ||= current_user.predictions.find(element.dataset[:id])
  end

  def update_scores
    find_prediction.tap do |prediction|
      current_score = prediction[team_score_attribute]
      prediction[team_score_attribute] = current_score + score_delta
      prediction.save
    end
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
end
