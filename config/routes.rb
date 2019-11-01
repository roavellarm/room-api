# frozen_string_literal: true

Rails.application.routes.draw do
  resources :faq, only: %i[index]
  resources :admin_texts, only: %i[index]
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    passwords: 'auth/passwords'
  }
  post 'auth/social_media/:provider', to: 'social_media#auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
