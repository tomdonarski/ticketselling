# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :ticket
end
