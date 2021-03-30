class PredictionComponent < ViewComponent::Base
  def initialize(prediction:)
    @prediction = prediction
  end

  def render?
    @prediction.kickoff_future?
  end
end
