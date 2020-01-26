# frozen_string_literal: true

module Fakers
  class BallRepository
    class << self
      def new(game_id:, knocked_pins:, frame:, roll:)
        create
      end

      private

      def create
        OpenStruct.new(id: 1, ball_id: 1, game: Fakers::GameRepository.new)
      end
    end
  end
end
