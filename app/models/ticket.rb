# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :event
  enum status: { available: 'available', reserved: 'reserved', processed: 'processed', sold: 'sold' }
end
