module Venues
  extend ActiveSupport::Concern

  included do
    validates :venue, presence: true

    enum venue: {
      amsterdam: 'Amsterdam',
      baku: 'Baku',
      bilbao: 'Bilbao',
      bucharest: 'Bucharest',
      budapest: 'Budapest',
      copenhagen: 'Copenhagen',
      dublin: 'Dublin',
      glasgow: 'Glasgow',
      london: 'London',
      munich: 'Munich',
      rome: 'Rome',
      saint_petersburg: 'Saint Petersburg'
    }, _prefix: :venue
  end
end
