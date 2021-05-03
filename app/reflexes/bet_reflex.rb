class BetReflex < ApplicationReflex
  def change_score
    update_scores
    update_bet_card
  end

  def start
    find_bet.home_team_score ||= 0
    find_bet.guest_team_score ||= 0
    find_bet.save
    update_bet_card
  end

  private

  def update_bet_card
    morph dom_id(find_bet),
          render(BetComponent.new(bet: find_bet.reload), layout: false)
  end

  def find_bet
    @find_bet ||= current_user.bets.find(element.dataset[:id])
  end

  def update_scores
    find_bet.tap do |bet|
      current_score = bet[team_score_attribute]
      bet[team_score_attribute] = current_score + score_delta
      bet.save
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
