class FinalWhistleService
  def call!
    Game.transaction do
      PredictionPointsService.new.call!
      UserRankingService.new.call!
      TeamsActiveMembersService.new.call!
    end
  end
end
