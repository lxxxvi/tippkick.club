class TeamMembershipsComponent < ViewComponent::Base
  include Pagy::Backend
  include Pagy::Frontend

  attr_reader :params, :user

  def initialize(team:, params:, user:)
    @team = team
    @params = params
    @user = user
    @pagy, @records = pagy(@team.memberships.with_users.ordered_by_ranking_position)
  end

  def display_pagination?
    @pagy.pages > 1
  end
end
