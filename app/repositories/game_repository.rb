# frozen_string_literal: true

class GameRepository
  class << self
    def new
      Game.create!
    end

    def find(id)
      Game.find(id)
    end

    def pins_by_frames(id)
      Game.find(id).balls.pluck(:frame, :knocked_pins).each_with_object({}) do |x, acc|
        frame_key = x.first.to_s
        acc[frame_key] = acc[frame_key] + [x.last] if acc[frame_key]
        acc[frame_key] = [x.last] unless acc[frame_key]
      end
    end
  end
end
