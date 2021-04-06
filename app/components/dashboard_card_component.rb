class DashboardCardComponent < ViewComponent::Base
  renders_one :icon
  renders_one :description
  renders_one :link, DashboardCardLinkComponent
end
