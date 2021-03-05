class Game < ApplicationRecord
  include TournamentPhases
  include Venues

  has_many :predictions, dependent: :destroy

  validates :uefa_game_id, :venue, :tournament_phase,
            :home_team_name, :guest_team_name,
            :home_team_score, :guest_team_score,
            :kickoff_at, presence: true

  validates :home_team_score, :guest_team_score,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :uefa_game_id, uniqueness: true

  validate :final_whistle_is_after_kickoff
  validate :scores_cannot_change_before_kickoff

  def final_whistle(reset: false)
    if reset
      self.final_whistle_at = nil
    else
      self.final_whistle_at ||= Time.zone.now
    end
    save
  end

  def final_whistle?
    final_whistle_at&.present?
  end

  def live?
    kickoff_past? && final_whistle_at.nil?
  end

  def kickoff_past?
    kickoff_at.past?
  end

  def kickoff_future?
    kickoff_at.future?
  end

  def decorate
    @decorate ||= GameDecorator.new(self)
  end

  private

  def final_whistle_is_after_kickoff
    return if final_whistle_at.nil?
    return if final_whistle_at > kickoff_at

    errors.add(:final_whistle_at, :cannot_be_before_kickoff)
  end

  def scores_cannot_change_before_kickoff
    return if kickoff_at.past?

    errors.add(:home_team_score, :cannot_be_changed_before_kickoff)
    errors.add(:guest_team_score, :cannot_be_changed_before_kickoff)
  end

  def scores_changed?
    home_team_score_changed? || guest_team_score_changed?
  end
end
