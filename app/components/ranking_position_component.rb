class RankingPositionComponent < ViewComponent::Base
  def initialize(ranking_position:, active_members:)
    @ranking_position = ranking_position
    @active_members = active_members
  end
end
