# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cmd::Balls::ThrowBall do
  let(:game_repo) { Fakers::GameRepository }
  let(:ball_repo) { Fakers::BallRepository }

  subject { described_class.run!(game_repo: game_repo, ball_repo: ball_repo, game_id: 1, knocked_pins: 1) }

  describe '.run!' do
    it { is_expected.to be_truthy }
  end
end
