class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :user_id, uniqueness: { scope: :team_id }

  scope :invited, -> { where(accepted_at: nil) }
  scope :accepted, -> { where.not(accepted_at: nil) }
  scope :with_teams, -> { includes(:team).joins(:team) }

  after_destroy :update_active_members
  after_save :update_active_members

  def accepted?
    accepted_at.present?
  end

  def invited?
    !accepted?
  end

  def mark_accepted
    self.accepted_at ||= Time.zone.now
  end

  def accept
    mark_accepted && save
  end

  def leave
    destroy
  end

  private

  def update_active_members
    TeamsActiveMembersService.new.call!
  end
end
