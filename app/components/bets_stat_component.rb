class BetsStatComponent < ViewComponent::Base
  def initialize(bets_stat:, bets_count:)
    @bets_stat = bets_stat
    @bets_count = bets_count
  end

  def render?
    @bets_count.positive?
  end

  def bet_final_score
    "#{@bets_stat.bet_home_team_score}:#{@bets_stat.bet_guest_team_score}"
  end

  def bet_percentage
    bets_stat_count_percentage
  end

  private

  def bets_stat_count_percentage
    @bets_stat_count_percentage ||= 100.0 * @bets_stat.bet_count / @bets_count
  end
end
