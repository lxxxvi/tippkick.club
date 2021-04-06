class DashboardCardLinkComponent < ViewComponent::Base
  def initialize(name:, path:)
    @name = name
    @path = path
  end
end
