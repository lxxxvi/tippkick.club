class Game < ApplicationRecord
  validates :venue, :tournament_phase,
            :home_team_name, :guest_team_name,
            :home_team_score, :guest_team_score,
            :kickoff_at, presence: true

  validates :home_team_score, :guest_team_score,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :tournament_phase, uniqueness: { scope: %i[home_team_name guest_team_name] }

  enum tournament_phase: {
    group: 'group',
    round_of_16: 'round_of_16',
    quarter_finals: 'quarter_finals',
    semi_finals: 'semi_finals',
    final: 'final'
  }, _prefix: true
end
