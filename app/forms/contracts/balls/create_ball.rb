# frozen_string_literal: true

module Contracts
  module Balls
    class CreateBall < Contracts::Base
      params do
        required(:game_id).value(:integer)
        required(:knocked_pins).value(:integer)
      end

      rule(:knocked_pins) do
        key.failure(text: 'must be greater than or equal to zero') if values[:knocked_pins].negative?
        key.failure(text: 'must be less than or equal to 10') if values[:knocked_pins] > 10
      end
    end
  end
end
