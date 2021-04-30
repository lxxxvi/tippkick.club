class BetsStat < ApplicationRecord
  belongs_to :game

  scope :ordered_by_scores, -> { order(bet_home_team_score: :asc, bet_guest_team_score: :asc) }
end
