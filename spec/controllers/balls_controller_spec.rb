# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BallsController, type: :controller do
  describe '#show' do
    let(:game) { create(:game) }
    let(:params) { { game_id: game.id, knocked_pins: 1 } }

    it 'should return a game with scores' do
      post :create, params: params

      expect(response.status).to eq 200
      expect(response).to match_json_schema('game_scores')
    end

    context 'when wrong params ' do
      let(:params) { { game_id: game.id } }

      it do
        post :create, params: params
        expect(response.status).to eq 422
      end
    end
  end
end
