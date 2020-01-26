# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe '#create' do
    it 'should return a game' do
      post :create

      expect(response.status).to eq 200
      expect(response).to match_json_schema('game')
    end
  end

  describe '#show' do
    let(:game) { create(:game) }
    let(:params) { { id: game.id } }

    before do
      create(:ball, game_id: game.id, frame: 1, roll: 1, knocked_pins: 5)
    end

    it 'should return a game with scores' do
      get :show, params: params

      expect(response.status).to eq 200
      expect(response).to match_json_schema('game_scores')
    end

    context 'when wrong params ' do
      let(:params) { { id: 0 } }

      it do
        get :show, params: params
        expect(response.status).to eq 404
      end
    end
  end
end
