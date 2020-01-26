# frozen_string_literal: true

module Fakers
  class GameRepository
    class << self
      def new
        create
      end

      def find
        create
      end

      def pins_by_frames(_id)
        { '1' => [1, 2], '2' => [0, 0], '3' => [10], '4' => [10], '5' => [2] }
      end

      private

      def create
        OpenStruct.new(id: 1)
      end
    end
  end
end
