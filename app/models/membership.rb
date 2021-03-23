class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :user_id, uniqueness: { scope: :team_id }

  scope :with_teams, -> { includes(:team).joins(:team) }
  scope :with_users, -> { includes(:user).joins(:user) }
  scope :ordered_by_ranking_position, -> { order(ranking_position: :asc) }

  after_destroy :update_members_count
  after_save :update_members_count

  def leave
    destroy
  end

  private

  def update_members_count
    TeamsActiveMembersService.new(team_ids: team_id).call!
  end
end
