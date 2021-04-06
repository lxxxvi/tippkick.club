class PredictionComponent < ViewComponent::Base
  def initialize(prediction:)
    @prediction = prediction
  end

  def render?
    @prediction.kickoff_future?
  end

  def border_color_class
    return 'border-pink-200' if @prediction.predictable?

    'border-gray-200'
  end

  def bg_color_class
    return 'bg-pink-200' if @prediction.predictable?

    'bg-gray-200'
  end
end
