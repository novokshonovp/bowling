# frozen_string_literal: true

class ThrowSerializer < ActiveModel::Serializer
  attributes :id, :frame_scores, :total_score

  def frame_scores
    scorer_game.frame_scores
  end

  def total_score
    scorer_game.current_score
  end

  private

  def scorer_game
    @scorer_game ||= TraditionalScoring::Scorer.new(game: GameRepository.pins_by_frames(object.id))
  end
end
