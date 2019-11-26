# frozen_string_literal: true

Rails.application.routes.draw do
  resources :faq, only: %i[index]
  resources :admin_texts, only: %i[index]
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    passwords: 'auth/passwords'
  }
  post 'auth/social_media/:provider', to: 'social_media#auth'

  resources :user, only: %i[index show]
  resources :org, only: %i[index create show]
  resources :feedback, only: %i[create]
  resources :room, only: %i[create]
  resources :chat, only: %i[create show]

  put '/user/change_mood', to: 'user#change_mood'
  put '/room_access', to: 'room#access'
  put '/org/:id/add_member', to: 'org#add_member'
end
