class Game < ApplicationRecord
  include TournamentPhases
  include Venues

  has_many :bets, dependent: :destroy

  validates :uefa_game_id, :venue, :tournament_phase,
            :home_team_score, :guest_team_score,
            :kickoff_at, presence: true

  validates :home_team_score, :guest_team_score,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :uefa_game_id, uniqueness: true

  validate :final_whistle_is_after_kickoff
  validate :scores_cannot_change_before_kickoff

  scope :ordered_chronologically, -> { order('kickoff_at ASC, uefa_game_id ASC') }
  scope :ordered_antichronologically, -> { order('kickoff_at DESC, uefa_game_id ASC') }

  before_save :sanitize_team_names
  after_save :call_final_whistle_service!, if: :scores_or_final_whistle_previously_changed?

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

  def bet_ready?
    kickoff_future? && teams_present?
  end

  def teams_present?
    home_team_name.present? && guest_team_name.present?
  end

  private

  def final_whistle_is_after_kickoff
    return if final_whistle_at.nil?
    return if final_whistle_at > kickoff_at

    errors.add(:final_whistle_at, :cannot_be_before_kickoff)
  end

  def scores_cannot_change_before_kickoff
    return if kickoff_at.past?
    return unless scores_changed?

    errors.add(:home_team_score, :cannot_be_changed_before_kickoff)
    errors.add(:guest_team_score, :cannot_be_changed_before_kickoff)
  end

  def scores_changed?
    home_team_score_changed? || guest_team_score_changed?
  end

  def scores_previously_changed?
    home_team_score_previously_changed? || guest_team_score_previously_changed?
  end

  def scores_or_final_whistle_previously_changed?
    scores_previously_changed? || final_whistle_at_previously_changed?
  end

  def call_final_whistle_service!
    FinalWhistleService.new.call!
  end

  def sanitize_team_names
    empty_to_nil(:home_team_name, :guest_team_name)
  end

  def empty_to_nil(*column_names)
    column_names.each do |column_name|
      self[column_name] = self[column_name].presence
    end
  end
end
