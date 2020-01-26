# frozen_string_literal: true

module Cmd
  module Games
    class NewGame < Cmd::Base
      interface :game_repo, default: GameRepository

      def execute
        game_repo.new
      end
    end
  end
end
