class BetComponent < ViewComponent::Base
  def initialize(bet:)
    @bet = bet
  end

  def render?
    @bet.kickoff_future?
  end

  def border_color_class
    return 'border-pink-300' if @bet.bet_ready?

    'border-gray-200'
  end

  def bg_color_class
    return 'bg-pink-300' if @bet.bet_ready?

    'bg-gray-200'
  end
end
