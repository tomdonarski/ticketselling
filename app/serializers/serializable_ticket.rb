class SerializableTicket < JSONAPI::Serializable::Resource
  type 'tickets'

  attributes :price, :status#, :event
end
