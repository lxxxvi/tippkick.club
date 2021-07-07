class FinalRankingComponent < CurrentRankingComponent
  def render?
    Tournament.after_last_final_whistle?
  end

  def global_winners
    @global_winners ||= User.where(id: Team.global.memberships.ranked_first.select(:user_id))
  end
end
