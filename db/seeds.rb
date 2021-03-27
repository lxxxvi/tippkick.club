Team.find_or_create_by(tippkick_id: :global).tap do |team|
  team.name = 'Global'
  team.invitation_token ||= SecureRandom.alphanumeric(32)
  team.members_count ||= 0
end
