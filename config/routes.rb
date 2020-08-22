Rails.application.routes.draw do
  resources :users
  get 'growth_curve_sample/index'
  post 'growth_curve_sample/destroy'
  post 'growth_curve_sample/create'
  root to: 'growth_curve_sample#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
