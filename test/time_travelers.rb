module TimeTravelers
  def before_tournament(&block)
    travel_to('2021-06-11 18:55:00 UTC', &block)
  end

  def in_game_1(&block)
    travel_to('2021-06-11 19:30:00 UTC', &block)
  end

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

  def before_game_45(&block)
    travel_to('2021-07-02 15:55:00 UTC', &block)
  end

  def in_game_45(&block)
    travel_to('2021-07-02 16:05:00 UTC', &block)
  end

  def at_kickoff_of_game_51(&block)
    travel_to('2021-07-11 19:00:00 UTC', &block)
  end

  def after_tournament(&block)
    travel_to('2021-07-11 21:00:00 UTC', &block)
  end
end
