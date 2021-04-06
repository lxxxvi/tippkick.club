class PredictionCardComponent < ViewComponent::Base
  renders_one :header
  renders_one :body
  renders_one :footer

  attr_reader :border_color_class, :bg_color_class

  def initialize(border_color_class:, bg_color_class:)
    @border_color_class = border_color_class
    @bg_color_class = bg_color_class
  end

  def border_and_bg_color_classes
    "#{border_color_class} #{bg_color_class}"
  end
end
