class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :home_team_score, :guest_team_score, :points,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            allow_nil: true

  validates :game_id, uniqueness: { scope: :user_id }

  validate :scores_cannot_change_after_kickoff

  scope :with_game, -> {
    includes(:game).joins(:game)
  }

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
