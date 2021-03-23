class TeamsActiveMembersService
  def initialize(team_ids: nil)
    @team_ids = Array(team_ids).map(&:to_i)
  end

  def call!
    Team.transaction do
      execute update_teams_members_count_sql
    end
  end

  private

  def execute(statement)
    ActiveRecord::Base.connection.execute(statement)
  end

  def update_teams_members_count_sql
    <<~SQL.squish
      WITH with_members_count AS (
        SELECT team_id    AS team_id
             , count(*)   AS members_count
          FROM memberships
         WHERE #{team_id_filter}
         GROUP BY team_id
      )

      UPDATE teams
         SET members_count = with_members_count.members_count
        FROM with_members_count
       WHERE with_members_count.team_id = teams.id
    SQL
  end

  def team_id_filter
    return '0 = 0' if @team_ids.empty?

    "team_id IN (#{@team_ids.join(', ')})"
  end
end
