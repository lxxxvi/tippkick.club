module TimeTravelers
  def before_game_25(&block)
    travel_to('2021-06-20 15:55:00 UTC', &block)
  end

  def at_kickoff_of_game_25(&block)
    travel_to('2021-06-20 16:00:00 UTC', &block)
  end

  def in_game_25(&block)
    travel_to('2021-06-20 16:05:00 UTC', &block)
  end

  def after_game_25(&block)
    travel_to('2021-06-20 17:45:00 UTC', &block)
  end
end
