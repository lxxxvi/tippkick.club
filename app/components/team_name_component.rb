class TeamNameComponent < ViewComponent::Base
  delegate :global?, to: :@team

  def initialize(team:)
    @team = team
  end
end
