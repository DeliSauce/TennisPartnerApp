Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions', :omniauth_callbacks => 'users/omniauth_callbacks'
      }

  #, :omniauth_callbacks => 'users/omniauth_callbacks'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "static_pages#root"
end
