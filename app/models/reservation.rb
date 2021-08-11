# frozen_string_literal: true

class Reservation < ApplicationRecord
  has_many :reserved_tickets
  has_many :tickets, through: :reserved_tickets
end
