Bugsnag.configure do |config|
  config.api_key = ENV['TIPPKICK_BUGSNAG_API_KEY']
  config.notify_release_stages = %w[production staging]
end
