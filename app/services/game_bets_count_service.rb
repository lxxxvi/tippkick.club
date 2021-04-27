class GameBetsCountService
  def initialize(game = nil)
    @game = game
  end

  def call!
    Game.transaction do
      execute reset_games_bets_count_sql
      execute update_games_bets_count_sql
    end
  end

  private

  def execute(statement)
    ApplicationRecord.connection.execute(statement)
  end

  def reset_games_bets_count_sql
    <<~SQL.squish
      UPDATE games
         SET bets_home_team_wins_count = 0
           , bets_guest_team_wins_count = 0
           , bets_draw_count = 0
       WHERE #{game_filter}
    SQL
  end

  def update_games_bets_count_sql
    <<~SQL.squish
      WITH scoped_games AS (
        SELECT *
          FROM games
         WHERE #{game_filter}
      )

      , scoped_bets AS (
        SELECT *
          FROM bets
         WHERE game_id IN (SELECT id FROM scoped_games)
      )

      , home_team_wins AS (
        SELECT game_id, count(*) AS bets_count FROM scoped_bets WHERE home_team_score > guest_team_score GROUP BY game_id
      )

      , guest_team_wins AS (
        SELECT game_id, count(*) AS bets_count FROM scoped_bets WHERE home_team_score < guest_team_score GROUP BY game_id
      )

      , draw AS (
        SELECT game_id, count(*) AS bets_count FROM scoped_bets WHERE home_team_score = guest_team_score GROUP BY game_id
      )

      , game_bets_count AS (
        SELECT g.id AS game_id
             , COALESCE(htw.bets_count, 0) AS bets_home_team_wins_count
             , COALESCE(gtw.bets_count, 0) AS bets_guest_team_wins_count
             , COALESCE(d.bets_count, 0)   AS bets_draw_count
          FROM scoped_games g
          LEFT OUTER JOIN home_team_wins htw  ON htw.game_id = g.id
          LEFT OUTER JOIN guest_team_wins gtw ON gtw.game_id = g.id
          LEFT OUTER JOIN draw d ON d.game_id = g.id
      )

      UPDATE games
         SET bets_home_team_wins_count  = game_bets_count.bets_home_team_wins_count
           , bets_guest_team_wins_count = game_bets_count.bets_guest_team_wins_count
           , bets_draw_count = game_bets_count.bets_draw_count
        FROM game_bets_count
       WHERE game_bets_count.game_id = games.id
    SQL
  end

  def game_filter
    return "id = #{@game.id}" if @game.present?

    '0 = 0'
  end
end
