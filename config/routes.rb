# frozen_string_literal: true

Rails.application.routes.draw do
  scope defaults: { format: 'json' } do
    resources :events, only: %i(index show)

    resources :tickets, only: %i(index) do
      collection do
        post :buy
      end
    end
    get 'available_tickets', to: 'tickets#available_tickets'
    get 'reserved_tickets', to: 'tickets#reserved_tickets'
    get 'sold_tickets', to: 'tickets#sold_tickets'
  end
end
