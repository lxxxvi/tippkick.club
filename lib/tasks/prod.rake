namespace :prod do
  desc 'To be run hourly'
  task hourly: :environment do
    GameBetsCountService.new.call!
    BetsStatsService.new.call!
  end
end
