class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :home_team_score, :guest_team_score,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            allow_nil: true

  validates :game_id, uniqueness: { scope: :user_id }

  validate :scores_cannot_change_after_kickoff

  scope :of_user, ->(user) { where(user: user) }
  scope :bet_pending, -> { where(home_team_score: nil, guest_team_score: nil) }
  scope :with_game, -> { includes(:game).joins(:game) }
  scope :ordered_chronologically, -> { includes(:game).order('games.kickoff_at ASC, games.uefa_game_id ASC') }
  scope :ordered_antichronologically, -> { includes(:game).order('games.kickoff_at DESC, games.uefa_game_id ASC') }
  scope :kickoff_future, -> { joins(:game).where('games.kickoff_at > :datetime', datetime: Time.zone.now) }
  scope :kickoff_past, -> { joins(:game).where('games.kickoff_at <= :datetime', datetime: Time.zone.now) }
  scope :bet_ready, -> do
    joins(:game).where('games.kickoff_at > :time', time: Time.zone.now)
                .where('games.home_team_name IS NOT NULL AND games.guest_team_name IS NOT NULL')
  end

  scope :bet_pending_and_ready, -> { bet_pending.bet_ready }

  delegate :kickoff_future?, :bet_ready?, to: :game

  after_save :update_game_bets_count

  def bet_complete?
    home_team_score.present? && guest_team_score.present?
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

  def update_game_bets_count
    GameBetsCountService.new(game).call!
  end
end
