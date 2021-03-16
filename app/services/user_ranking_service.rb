class UserRankingService
  def call!
    User.transaction do
      execute update_global_ranking_positions_sql
    end
  end

  private

  def execute(statement)
    ApplicationRecord.connection.execute(statement)
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
end
