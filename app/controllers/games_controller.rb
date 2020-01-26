# frozen_string_literal: true

class GamesController < ApplicationController
  def index; end

  def create
    use_case = Cmd::Games::NewGame
    render json: use_case.run!
  end

  def show
    contract = Contracts::Games::ShowGame.new(permited_params)
    contract.validate!

    render json: GameRepository.find(contract.attributes[:id]), serializer: ::ThrowSerializer
  end

  private

  def permited_params
    params.permit(:id).to_h
  end
end
