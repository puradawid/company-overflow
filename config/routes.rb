Rails.application.routes.draw do
  devise_for :companies
  root  'static_pages#home'
end
