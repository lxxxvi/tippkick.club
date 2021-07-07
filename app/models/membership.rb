class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  validates :user_id, uniqueness: { scope: :team_id }

  scope :with_teams, -> { includes(:team).joins(:team) }
  scope :with_users, -> { includes(:user).joins(:user) }
  scope :ordered_by_ranking_position, -> {
    with_users.order('memberships.ranking_position ASC, users.nickname ASC')
  }
  scope :ordered_by_global_and_team_name, -> {
    with_teams.order(Arel.sql("CASE WHEN teams.tippkick_id = 'global' THEN 1 ELSE 2 END, teams.name"))
  }
  scope :ranked_first, -> { where(ranking_position: 1) }

  after_destroy :update_stats
  after_save :update_stats

  def leave
    destroy
  end

  private

  def update_stats
    TeamRankingService.new(team_ids: team_id).call!
    TeamMembersCountService.new(team_ids: team_id).call!
  end
end
