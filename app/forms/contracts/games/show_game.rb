# frozen_string_literal: true

module Contracts
  module Games
    class ShowGame < Contracts::Base
      params do
        required(:id).value(:integer)
      end
    end
  end
end
