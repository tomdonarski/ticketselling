# frozen_string_literal: true

class ReservedTicket < ApplicationRecord
  belongs_to :ticket
  belongs_to :reservation
end
