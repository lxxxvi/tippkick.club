class TeamRankingService
  def initialize(team_ids: nil)
    @team_ids = Array(team_ids).map(&:to_i)
  end

  def call!
    Membership.transaction do
      execute reset_memberships_ranking_positions_sql
      execute update_memberships_ranking_positions_sql
    end
  end

  private

  def execute(statement)
    ApplicationRecord.connection.execute(statement)
  end

  def reset_memberships_ranking_positions_sql
    <<~SQL.squish
      UPDATE memberships SET ranking_position = NULL
    SQL
  end

  def update_memberships_ranking_positions_sql
    <<~SQL.squish
      WITH with_memberships_ranking_position AS (
        SELECT m.id                                           AS membership_id
             , u.id                                           AS user_id
             , u.total_points                                 AS user_total_points
             , m.team_id                                      AS team_id
             , RANK() OVER (PARTITION BY m.team_id
                                ORDER BY u.total_points DESC) AS ranking_position
          FROM memberships m
         INNER JOIN users u ON u.id = m.user_id
         WHERE #{team_id_filter}
      )
      UPDATE memberships
         SET ranking_position = with_memberships_ranking_position.ranking_position
        FROM with_memberships_ranking_position
       WHERE with_memberships_ranking_position.membership_id = memberships.id
    SQL
  end

  def team_id_filter
    return '0 = 0' if @team_ids.empty?

    "team_id IN (#{@team_ids.join(', ')})"
  end
end
