Rails.application.routes.draw do
  resources :users
  get 'growth_curve_sample/index'
  get 'growth_curve_sample/edit'
  post 'growth_curve_sample/destroy'
  post 'growth_curve_sample/create'
  post 'growth_curve_sample/update'
  root to: 'growth_curve_sample#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
