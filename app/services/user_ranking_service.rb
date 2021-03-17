class UserRankingService
  def call!
    User.transaction do
      execute reset_global_ranking_positions_sql
      execute reset_memberships_ranking_positions_sql
      execute update_global_ranking_positions_sql
      execute update_memberships_ranking_positions_sql
    end
  end

  private

  def execute(statement)
    ApplicationRecord.connection.execute(statement)
  end

  def reset_global_ranking_positions_sql
    <<~SQL.squish
      UPDATE users SET global_ranking_position = NULL
    SQL
  end

  def reset_memberships_ranking_positions_sql
    <<~SQL.squish
      UPDATE memberships SET ranking_position = NULL
    SQL
  end

  def update_global_ranking_positions_sql
    <<~SQL.squish
      WITH ranked_by_total_points AS (
        SELECT id
             , RANK() OVER (ORDER BY COALESCE(total_points, 0) DESC) AS global_ranking_position
             , total_points
          FROM users
      )
      UPDATE users
         SET global_ranking_position = ranked_by_total_points.global_ranking_position
        FROM ranked_by_total_points
       WHERE users.id = ranked_by_total_points.id
    SQL
  end

  def update_memberships_ranking_positions_sql
    <<~SQL.squish
      WITH with_memberships_ranking_position AS (
        SELECT m.id                                           AS membership_id
             , u.id                                           AS user_id
             , u.total_points                                 AS user_total_points
             , m.user_group_id                                AS user_group_id
             , RANK() OVER (PARTITION BY m.user_group_id
                                ORDER BY u.total_points DESC) AS ranking_position
          FROM memberships m
          INNER JOIN users u ON u.id = m.user_id
      )
      UPDATE memberships
         SET ranking_position = with_memberships_ranking_position.ranking_position
        FROM with_memberships_ranking_position
       WHERE with_memberships_ranking_position.membership_id = memberships.id
    SQL
  end
end
