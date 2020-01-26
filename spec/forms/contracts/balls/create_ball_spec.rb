# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contracts::Balls::CreateBall do
  describe '#call' do
    subject { described_class.new(params).result }

    context 'when all params are correct' do
      let(:params) { { game_id: 1, knocked_pins: 10 } }

      it 'should return success' do
        expect(subject.errors.to_h).to eq({})
      end
    end

    context 'when id of game doesnt exist' do
      let(:params) { { knocked_pins: 10 } }

      it 'should return errors' do
        expect(subject.errors.to_h).to include(game_id: ['is missing'])
      end
    end

    describe 'Bowling is played by throwing a ball down a narrow alley towards ten wooden pins' do
      context 'when pins less than 0' do
        let(:params) { { game_id: 1, knocked_pins: -1 } }

        it 'should return errors' do
          expect(subject.errors.to_h).to include(knocked_pins: ['must be greater than or equal to zero'])
        end
      end

      context 'when pins more than 10' do
        let(:params) { { game_id: 1, knocked_pins: 100 } }

        it 'should return errors' do
          expect(subject.errors.to_h).to include(knocked_pins: ['must be less than or equal to 10'])
        end
      end
    end
  end
end
