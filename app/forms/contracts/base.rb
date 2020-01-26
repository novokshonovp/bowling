# frozen_string_literal: true

module Contracts
  class Base < Dry::Validation::Contract
    def initialize(params)
      @params = params
      super()
    end

    def validate!
      result = call(@params)
      raise Contracts::ContractError, result unless result.success?
    end

    def result
      call(@params)
    end

    def attributes
      call(@params).to_h
    end
  end
end
