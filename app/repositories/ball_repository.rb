# frozen_string_literal: true

class BallRepository
  class << self
    def new(game_id:, knocked_pins:, frame:, roll:)
      Ball.create!(game_id: game_id, knocked_pins: knocked_pins, frame: frame, roll: roll)
    end
  end
end
