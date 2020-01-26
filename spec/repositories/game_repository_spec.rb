# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameRepository do
  describe '.new' do
    subject { described_class.new }

    it 'should create record' do
      expect { subject }.to change(Game, :count).by(1)
      is_expected.to eq(Game.last)
    end
  end

  describe '.find' do
    let(:game) { create(:game) }

    subject { described_class.find(game.id) }

    it 'should find record' do
      is_expected.to eq(game)
    end
  end
end
