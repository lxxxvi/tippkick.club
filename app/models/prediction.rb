class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :home_team_score, :guest_team_score,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            allow_nil: true

  validates :game_id, uniqueness: { scope: :user_id }

  validate :scores_cannot_change_after_kickoff

  scope :of_user, ->(user) { where(user: user) }
  scope :with_game, -> { includes(:game).joins(:game) }
  scope :ordered_chronologically, -> { includes(:game).order('games.kickoff_at ASC, games.uefa_game_id ASC') }
  scope :ordered_antichronologically, -> { includes(:game).order('games.kickoff_at DESC, games.final_whistle_at DESC') }
  scope :kickoff_future, -> { joins(:game).where('games.kickoff_at > :datetime', datetime: Time.zone.now) }
  scope :kickoff_past, -> { joins(:game).where('games.kickoff_at <= :datetime', datetime: Time.zone.now) }

  delegate :kickoff_future?, to: :game

  def predicted?
    home_team_score.present? && guest_team_score.present?
  end

  def points_assigned?
    home_team_score_points.present? &&
      guest_team_score_points.present? &&
      result_points.present? &&
      perfect_prediction_bonus_points.present?
  end

  def total_points
    return unless points_assigned?

    home_team_score_points +
      guest_team_score_points +
      result_points +
      perfect_prediction_bonus_points
  end

  private

  def scores_cannot_change_after_kickoff
    return unless scores_changed?
    return if game.kickoff_at.future?

    errors.add(:home_team_score, :cannot_be_changed_after_kickoff)
    errors.add(:guest_team_score, :cannot_be_changed_after_kickoff)
  end

  def scores_changed?
    home_team_score_changed? || guest_team_score_changed?
  end
end
