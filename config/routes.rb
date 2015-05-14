Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :companies
  root  'static_pages#home'
  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  
  get 'members', to: 'members#index'
  post 'members/invite', to: 'members#invite'
  get 'members/confirm/:token', to: 'members#confirm', as: 'members_confirm'
  delete 'members/:company/:uid', to: 'members#remove'
  
end
