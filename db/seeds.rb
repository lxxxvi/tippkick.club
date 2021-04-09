def load_seeds(seed_name)
  file_name = "./seeds/#{seed_name}.rb"
  Rails.logger.info "Loading #{file_name}"
  require_relative file_name
end

load_seeds 'teams'
load_seeds 'users'
load_seeds 'games'
