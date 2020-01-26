# frozen_string_literal: true

module TraditionalScoring
  class Scorer
    STRIKE_PINS = 10
    SPARE_PINS = 10
    MAX_FRAMES = 10

    def initialize(game:)
      @game = game
    end

    def game_frame
      return 1 if @game.empty?

      return MAX_FRAMES if game_closed?

      frame_closed? ? last_frame + 1 : last_frame
    end

    def game_closed?
      return false if @game.empty?
      return false if last_frame == MAX_FRAMES && strike_frame? && last_rolls.size < 3
      return false if last_frame == MAX_FRAMES && spare_frame? && last_rolls.size < 3
      return false if last_frame != MAX_FRAMES
      return false if last_frame == MAX_FRAMES && last_rolls.size < 2

      true
    end

    def frame_closed?
      return true if strike_frame?
      return true if last_rolls.size == 2
      return true if game_closed?

      false
    end

    def current_score
      scores[:score]
    end

    def frame_scores
      scores[:scores]
    end

    def next_frame
      game_frame
    end

    def next_roll
      return 1 if @game.empty?

      frame_closed? ? 1 : 2
    end

    private

    def last_frame
      last_frame_roll.first.to_i
    end

    def last_rolls
      last_frame_roll.last
    end

    def last_frame_roll
      @last_frame_roll ||= @game.to_a.last
    end

    def strike_frame?
      last_rolls.first == STRIKE_PINS
    end

    def spare_frame?
      last_rolls.first(2).sum == SPARE_PINS
    end

    def scores
      @game.reduce(frame_number: 1, score: 0, scores: {}, last_frame_score: 0) do |acc, frame_data|
        frame_score = do_frame_score(acc[:frame_number], frame_data.last, acc[:score])

        { frame_number: acc[:frame_number] + 1, score: frame_score, scores: acc[:scores].merge(acc[:frame_number].to_s => frame_score), last_frame_score: frame_score }
      end
    end

    def do_frame_score(frame_number, frame_rolls, last_frame_score)
      if  frame_number == MAX_FRAMES
        last_frame_score + frame_rolls.sum
      elsif frame_rolls.first == STRIKE_PINS
        frame_rolls.last(2).sum + last_frame_score + next_two_balls(frame_number).sum
      elsif frame_rolls.first(2).sum == SPARE_PINS
        frame_rolls.last(2).sum + last_frame_score + [frame_rolls(frame_number + 1)&.first].compact.sum
      else
        last_frame_score + frame_rolls.sum
      end
    end

    def frame_rolls(frame_number)
      @game[frame_number.to_s]
    end

    def next_two_balls(frame_number)
      return [] unless frame_rolls(frame_number + 1)

      frame_rolls(frame_number + 1).size == 1 ? frame_rolls(frame_number + 1) + [frame_rolls(frame_number + 2)&.first].compact : frame_rolls(frame_number + 1).first(2)
    end
  end
end
