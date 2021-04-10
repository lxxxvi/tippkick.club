class CreateBetsService
  def initialize(user)
    @user = user
  end

  def call!
    execute create_bets_sql
  end

  private

  def execute(statement)
    ApplicationRecord.connection.execute(statement)
  end

  def create_bets_sql
    <<~SQL.squish
      INSERT INTO bets (user_id, game_id, created_at, updated_at)
      SELECT u.id
           , g.id
           , NOW()
           , NOW()
        FROM users u
        CROSS JOIN games g
       WHERE u.id = #{@user.id.to_i}
    SQL
  end
end
