class NavigationLinkComponent < ViewComponent::Base
  def initialize(name, options = {})
    @name = name
    @options = options
  end
end
