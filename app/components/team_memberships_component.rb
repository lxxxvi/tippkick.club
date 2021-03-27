class TeamMembershipsComponent < ViewComponent::Base
  include Pagy::Backend
  include Pagy::Frontend

  attr_reader :params

  def initialize(team:, params:)
    @team = team
    @params = params
    @pagy, @records = pagy(@team.memberships.with_users.ordered_by_ranking_position)
  end

  def display_pagination?
    @pagy.pages > 1
  end
end
