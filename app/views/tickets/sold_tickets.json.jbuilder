# frozen_string_literal: true

json.tickets do
  json.array! @tickets, :id, :price, :status
end
