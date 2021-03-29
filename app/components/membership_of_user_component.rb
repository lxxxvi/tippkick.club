class MembershipOfUserComponent < ViewComponent::Base
  def initialize(membership_of_user:)
    @membership_of_user = membership_of_user
  end
end
