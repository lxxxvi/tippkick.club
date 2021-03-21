class TeamsActiveMembersService
  def call!
    Team.transaction do
      execute update_teams_active_members_sql
    end
  end

  private

  def execute(statement)
    ActiveRecord::Base.connection.execute(statement)
  end

  def update_teams_active_members_sql
    <<~SQL
      WITH with_active_members AS (
        SELECT t.id         AS team_id
             , count(m.*)   AS active_members
          FROM teams t
         INNER JOIN memberships m ON m.team_id = t.id
         WHERE m.accepted_at IS NOT NULL
         GROUP BY t.id
      )

      UPDATE teams
         SET active_members = with_active_members.active_members
        FROM with_active_members
       WHERE with_active_members.team_id = teams.id
    SQL
  end
end
