class FinalWhistleService
  def call!
    Game.transaction do
      PredictionPointsService.new.call!
      GlobalRankingService.new.call!
      TeamRankingService.new.call!
      TeamsActiveMembersService.new.call!
    end
  end
end
