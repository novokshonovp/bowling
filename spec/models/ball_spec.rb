# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ball, type: :model do
  it { should belong_to(:game) }
end
