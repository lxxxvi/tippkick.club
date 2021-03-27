class FinalWhistleService
  def call!
    Game.transaction do
      PredictionPointsService.new.call!
      TeamRankingService.new.call!
      TeamMembersCountService.new.call!
    end
  end
end
