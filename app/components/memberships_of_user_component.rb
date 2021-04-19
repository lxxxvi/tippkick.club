class MembershipsOfUserComponent < ViewComponent::Base
  def initialize(memberships_of_user:)
    @memberships_of_user = memberships_of_user
  end

  def show_ranking?
    Tournament.after_first_kickoff?
  end
end
