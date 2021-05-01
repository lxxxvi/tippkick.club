class BetOutcomeComponent < ViewComponent::Base
  def initialize(game:)
    @game = game
  end

  def render?
    @game.bets_count.positive?
  end

  def display_bets_home_team_wins_percentage
    to_percentage_display(bets_home_team_wins_percentage)
  end

  def display_bets_guest_team_wins_percentage
    to_percentage_display(bets_guest_team_wins_percentage)
  end

  def display_bets_draw_percentage
    to_percentage_display(bets_draw_percentage)
  end

  def bets_home_team_wins_percentage
    @bets_home_team_wins_percentage ||= calculate_percentage(@game.bets_home_team_wins_count)
  end

  def bets_guest_team_wins_percentage
    @bets_guest_team_wins_percentage ||= calculate_percentage(@game.bets_guest_team_wins_count)
  end

  def bets_draw_percentage
    @bets_draw_percentage ||= calculate_percentage(@game.bets_draw_count)
  end

  private

  def to_percentage_display(value)
    "#{value.round}%"
  end

  def calculate_percentage(value)
    100.0 * value / @game.bets_count
  end
end
