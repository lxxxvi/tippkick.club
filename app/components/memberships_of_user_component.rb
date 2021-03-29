class MembershipsOfUserComponent < ViewComponent::Base
  def initialize(memberships_of_user:)
    @memberships_of_user = memberships_of_user
  end
end
