# frozen_string_literal: true

Rails.application.routes.draw do
  resources :faq, only: %i[index]
  resources :admin_texts, only: %i[index]
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    passwords: 'auth/passwords'
    # registrations: 'auth/registrations'
  }
  post 'auth/social_media/:provider', to: 'social_media#auth'

  resources :user, only: %i[index show update]
  resources :org, only: %i[index create show]
  resources :feedback, only: %i[create]
  resources :room, only: %i[create]
  resources :chat, only: %i[create show]

  put '/room_access', to: 'room#access'
  put '/org/:id/add_member', to: 'org#add_member'
  put '/user/:id/leave_rooms', to: 'user#leave_rooms'
end
