# frozen_string_literal: true

module Cmd
  class CmdError < ::StandardError
    attr_reader :resource

    def initialize(resource)
      @resource = resource
    end
  end
end
