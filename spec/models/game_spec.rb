# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should have_many(:balls) }
end
