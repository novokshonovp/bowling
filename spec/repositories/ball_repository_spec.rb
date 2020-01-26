# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BallRepository do
  let(:game) { create(:game) }

  describe '.new' do
    subject { described_class.new(game_id: game.id, knocked_pins: 1, frame: 1, roll: 1) }

    it 'should create a new record' do
      expect { subject }.to change(Ball, :count).by(1)
      is_expected.to eq(Ball.last)
    end
  end
end
