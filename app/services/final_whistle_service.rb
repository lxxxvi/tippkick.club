class FinalWhistleService
  def call!
    Game.transaction do
      BetPointsService.new.call!
      TeamRankingService.new.call!
      TeamMembersCountService.new.call!
    end
  end
end
