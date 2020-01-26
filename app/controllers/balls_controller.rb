# frozen_string_literal: true

class BallsController < ApplicationController
  def create
    contract = Contracts::Balls::CreateBall.new(permited_params)
    contract.validate!

    use_case = Cmd::Balls::ThrowBall
    render json: use_case.run!(contract.attributes), serializer: ::ThrowSerializer
  end

  private

  def permited_params
    params.permit(:game_id, :knocked_pins).to_h
  end
end
