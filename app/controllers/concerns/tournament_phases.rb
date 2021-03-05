module TournamentPhases
  extend ActiveSupport::Concern

  included do
    validates :tournament_phase, presence: true
    validates :tournament_phase, uniqueness: { scope: %i[home_team_name guest_team_name] }

    enum tournament_phase: {
      group: 'group',
      round_of_16: 'round_of_16',
      quarter_finals: 'quarter_finals',
      semi_finals: 'semi_finals',
      final: 'final'
    }, _suffix: :phase
  end
end
