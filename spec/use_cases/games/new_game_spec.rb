# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cmd::Games::NewGame do
  let(:game_repo) { Fakers::GameRepository }
  subject { described_class.run!(game_repo: game_repo) }

  describe '.run!' do
    it { is_expected.to be_truthy }
  end
end
