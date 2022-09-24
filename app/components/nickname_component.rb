class NicknameComponent < ViewComponent::Base
  delegate :titles, :titles?, to: :@user

  def initialize(user:, rooting_for_team: false)
    @user = user
    @rooting_for_team = rooting_for_team
  end

  def nickname
    tag.span do
      concat(tag.span(@user.nickname, class: "nickname"))
      concat(tag.span(rooting_for_team_as_emoji, class: "rooting-for-team ml-2")) if rooting_for_team?
    end
  end

  private

  def rooting_for_team?
    @rooting_for_team
  end

  def rooting_for_team_as_emoji
    @rooting_for_team_as_emoji ||= FlagService.emoji(@user.rooting_for_team)
  end
end
