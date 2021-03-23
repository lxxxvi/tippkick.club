class RankingPositionComponent < ViewComponent::Base
  def initialize(ranking_position:, members_count:)
    @ranking_position = ranking_position
    @members_count = members_count
  end
end
