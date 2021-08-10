# frozen_string_literal: true

json.event do
  json.extract! @event, :id, :name, :formatted_time
  json.tickets do
    json.array! @event.tickets, :id, :price, :status
  end
end
