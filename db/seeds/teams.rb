Team.find_or_create_by(tippkick_id: :global).tap do |global_team|
  global_team.name = 'Global'
  global_team.invitation_token ||= SecureRandom.alphanumeric(32)
  global_team.members_count ||= 0
  global_team.save!

  Rails.logger.info '  - Global team created'
end
