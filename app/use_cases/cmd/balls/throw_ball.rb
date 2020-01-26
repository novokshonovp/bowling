# frozen_string_literal: true

module Cmd
  module Balls
    class ThrowBall < Cmd::Base
      integer :game_id
      integer :knocked_pins

      interface :game_repo, default: GameRepository
      interface :ball_repo, default: BallRepository
      interface :scorer, default: TraditionalScoring::Scorer

      def execute
        raise Cmd::CmdError, self if scorer_game.game_closed?

        roll = ball_repo.new(game_id: game_id, knocked_pins: knocked_pins, frame: next_frame, roll: next_roll)
        roll.game
      end

      private

      def next_frame
        scorer_game.next_frame
      end

      def next_roll
        scorer_game.next_roll
      end

      def scorer_game
        @scorer_game ||= TraditionalScoring::Scorer.new(game: game_repo.pins_by_frames(game_id))
      end
    end
  end
end
