# frozen_string_literal: true

module Contracts
  class ContractError < ::StandardError
    attr_reader :resource

    def initialize(resource)
      @resource = resource
    end
  end
end
