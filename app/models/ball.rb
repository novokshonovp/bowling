# frozen_string_literal: true

class Ball < ApplicationRecord
  belongs_to :game

  default_scope { order(id: :asc) }
end
