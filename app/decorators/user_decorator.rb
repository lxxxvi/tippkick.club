class UserDecorator < SimpleDelegator
  def nickname_with_team_emoji
    "#{nickname} #{rooting_for_team_as_emoji}"
  end

  def rooting_for_team_as_emoji
    @rooting_for_team_as_emoji ||= FlagService.emoji(rooting_for_team)
  end
end
