# frozen_string_literal: true

class ServiceLocator
  class Container
    include Dry::Container::Mixin
  end

  class << self
    attr_reader :instance

    def configure
      container = Container.new
      yield(container)
      @instance = new(Rails.application, container)
      freeze
    end

    def [](name)
      instance[name]
    end
  end

  attr_reader :app, :container

  def initialize(app, container)
    @app = app
    @container = container
  end

  def [](name)
    container[name]
  end
end

ServiceLocator.configure do |container|
  if Rails.env.development?
    container.register(:game_repository, -> { GameRepository })
  elsif Rails.env.test?
    container.register(:game_repository, -> { Fakers::GameRepository })
  else
    container.register(:game_repository, -> { GameRepository })
  end
end
