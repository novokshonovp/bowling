# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TraditionalScoring::Scorer do
  let(:last_frame) { described_class::MAX_FRAMES }

  subject { described_class.new(game: game) }

  describe 'The game is played in ten frames.' do
    context 'when got two throws' do
      context 'when made a strike' do
        let(:game) { { '1' => [10] } }

        it { expect(subject.frame_closed?).to be true }
      end

      context 'when spare scored' do
        let(:game) { { '1' => [5, 5] } }

        it { expect(subject.frame_closed?).to be true }
      end

      context 'when zero scored' do
        let(:game) { { '1' => [0] } }

        it { expect(subject.frame_closed?).to be false }
      end
    end

    context 'when in the last frame' do
      context 'If a strike is thrown in the tenth frame' do
        let(:throws) { { '1' => [10], '2' => [10], '3' => [10], '4' => [10], '5' => [10], '6' => [10], '7' => [10], '8' => [10], '9' => [10], '10' => [10] } }

        context 'when did 10 throw' do
          let(:game) { throws }
          it 'the player may throw two more balls to complete the score of the strike' do
            expect(subject.game_closed?).to be false
          end
        end

        context 'when did 11 throw' do
          let(:game) { throws.merge('10' => [10, 1]) }
          it 'the player may throw a one more ball to complete the score of the strike' do
            expect(subject.game_closed?).to be false
          end
        end

        context 'when did 12 throw' do
          let(:game) { throws.merge('10' => [10, 1, 1]) }
          it 'should close game' do
            expect(subject.game_closed?).to be true
          end
        end
      end

      context 'if a spare is thrown in the tenth frame' do
        let(:throws) { { '1' => [10], '2' => [10], '3' => [10], '4' => [10], '5' => [10], '6' => [10], '7' => [10], '8' => [10], '9' => [10], '10' => [5, 5] } }

        context 'when did 11 throw' do
          let(:game) { throws }
          it 'the player may throw one more balls to complete the score of the strike' do
            expect(subject.game_closed?).to be false
          end
        end

        context 'when did 12 throw' do
          let(:game) { throws.merge('10' => [5, 5, 1]) }
          it 'should close game' do
            expect(subject.game_closed?).to be true
          end
        end
      end

      context 'when made a regular throw' do
        let(:game) { { '1' => [10], '2' => [10], '3' => [10], '4' => [10], '5' => [10], '6' => [10], '7' => [10], '8' => [10], '9' => [10], '10' => [0, 0] } }

        it 'should close the game' do
          expect(subject.game_closed?).to be true
        end
      end
    end
  end

  describe '#current_score' do
    subject { described_class.new(game: game).current_score }

    context 'when a strike frame scored' do
      let(:game) { { '1' => [10], '2' => [0, 1], '3' => [0, 1] } }

      it 'by adding ten plus the number of pins knocked down by the next two balls, to the score of the previous frame.' do
        is_expected.to eq(13)
      end
    end

    context 'when made all strikes' do
      let(:game) { { '1' => [10], '2' => [10], '3' => [10], '4' => [10], '5' => [10], '6' => [10], '7' => [10], '8' => [10], '9' => [10], '10' => [10, 10, 10] } }

      it 'by adding ten plus the number of pins knocked down by the next two balls, to the score of the previous frame.' do
        is_expected.to eq(300)
      end
    end

    context 'when made all strikes with last two zeroes' do
      let(:game) { { '1' => [10], '2' => [10], '3' => [10], '4' => [10], '5' => [10], '6' => [10], '7' => [10], '8' => [10], '9' => [10], '10' => [10, 0, 0] } }

      it { is_expected.to eq(270) }
    end

    context 'when made all strikes with last spare' do
      let(:game) { { '1' => [10], '2' => [10], '3' => [10], '4' => [10], '5' => [10], '6' => [10], '7' => [10], '8' => [10], '9' => [10], '10' => [5, 5, 5] } }

      it { is_expected.to eq(270) }
    end

    context 'when made a regular game' do
      let(:game) { { '1' => [1, 2], '2' => [0, 0], '3' => [10], '4' => [10], '5' => [2, 5], '6' => [5, 5], '7' => [0, 0], '8' => [0, 0], '9' => [0, 5], '10' => [5, 5, 1] } }

      it { is_expected.to eq(75) }
    end
  end

  describe '#next_frame' do
    subject { described_class.new(game: game).next_frame }

    context 'when a strike frame scored' do
      let(:game) { { '1' => [10] } }

      it { is_expected.to eq(2) }
    end

    context 'when a frame is open' do
      let(:game) { { '1' => [1] } }

      it { is_expected.to eq(1) }
    end
  end

  describe '#next_roll' do
    subject { described_class.new(game: game).next_roll }

    context 'when a strike frame scored' do
      let(:game) { { '1' => [10] } }

      it { is_expected.to eq(1) }
    end

    context 'when a frame is open' do
      let(:game) { { '1' => [1] } }

      it { is_expected.to eq(2) }
    end
  end

  describe '#frame_scores' do
    let(:game) { { '1' => [1, 2], '2' => [0, 0], '3' => [10], '4' => [10], '5' => [2, 5], '6' => [5, 5], '7' => [0, 0], '8' => [0, 0], '9' => [0, 5], '10' => [5, 5, 1] } }
    let(:result) { { '1' => 3, '2' => 3, '3' => 25, '4' => 42, '5' => 49, '6' => 59, '7' => 59, '8' => 59, '9' => 64, '10' => 75 } }

    subject { described_class.new(game: game).frame_scores }

    it { is_expected.to eq(result) }
  end
end
