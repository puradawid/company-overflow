Rails.application.routes.draw do
  root  'static_pages#home'

  get 'homehaml' => 'static_pages#homehaml'
end
