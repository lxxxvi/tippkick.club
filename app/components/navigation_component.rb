class NavigationComponent < ViewComponent::Base
  def initialize(signed_in:)
    @signed_in = signed_in
  end

  def signed_in?
    @signed_in
  end
end
