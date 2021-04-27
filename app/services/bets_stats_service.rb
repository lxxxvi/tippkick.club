class BetsStatsService
  def call!
    BetsStat.transaction do
      execute truncate_bets_stats_sql
      execute insert_bets_stats_sql
    end
  end

  private

  def execute(statement)
    ApplicationRecord.connection.execute(statement)
  end

  def truncate_bets_stats_sql
    'DELETE FROM bets_stats'
  end

  def insert_bets_stats_sql
    <<~SQL.squish
      WITH all_bet_scores AS (
        SELECT game_id            AS game_id
             , home_team_score    AS bet_home_team_score
             , guest_team_score   AS bet_guest_team_score
          FROM bets
         WHERE home_team_score  IS NOT NULL
           AND guest_team_score IS NOT NULL
      )

      , grouped_bet_scores AS (
       SELECT game_id
            , bet_home_team_score
            , bet_guest_team_score
            , count(*)             AS bet_count
         FROM all_bet_scores
        GROUP BY game_id
               , bet_home_team_score
               , bet_guest_team_score
      )

      INSERT INTO bets_stats (
          game_id
        , bet_home_team_score
        , bet_guest_team_score
        , bet_count
      )
      SELECT game_id
           , bet_home_team_score
           , bet_guest_team_score
           , bet_count
        FROM grouped_bet_scores
    SQL
  end
end
