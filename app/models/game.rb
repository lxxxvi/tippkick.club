class Game < ApplicationRecord
  validates :venue, :tournament_phase,
            :home_team_name, :guest_team_name,
            :home_team_score, :guest_team_score,
            :kickoff_at, presence: true

  validates :home_team_score, :guest_team_score,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :tournament_phase, uniqueness: { scope: %i[home_team_name guest_team_name] }

  validate :final_whistle_is_after_kickoff
  validate :scores_can_only_be_changed_after_kickoff

  enum tournament_phase: {
    group: 'group',
    round_of_16: 'round_of_16',
    quarter_finals: 'quarter_finals',
    semi_finals: 'semi_finals',
    final: 'final'
  }, _suffix: :phase

  def final_whistle
    update(final_whistle_at: Time.zone.now)
  end

  private

  def final_whistle_is_after_kickoff
    return if final_whistle_at.nil?
    return if final_whistle_at > kickoff_at

    errors.add(:final_whistle_at, :cannot_be_before_kickoff)
  end

  def scores_can_only_be_changed_after_kickoff
    return unless scores_changed?
    return if kickoff_at.past?

    errors.add(:home_team_score, :cannot_be_changed_before_kickoff)
    errors.add(:guest_team_score, :cannot_be_changed_before_kickoff)
  end

  def scores_changed?
    home_team_score_changed? || guest_team_score_changed?
  end
end