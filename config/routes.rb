Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'ad_requests#new'
  get 'get_quote' => 'leads#new'

  resources :ads, path:'/discounts', only: [:show]
  resources :ad_requests, path:'/quotes', only: [:new, :show, :create]
  resources :leads, path:'/quote_forms', only: [:new, :create, :index]
  resources :articles, only: [:show, :index]

  get 'vantage_media' => 'revenues#vantage_media'
  get 'revi_media' => 'revenues#revi_media'

  # static pages
  get 'about' => 'static_pages#about'
  get 'privacy_policy' => 'static_pages#privacy_policy'
  get 'terms_of_use' => 'static_pages#terms_of_use'

  # reports
  get 'reports/' => 'reports#index'
  get 'reports/today' => 'reports#today'
  get 'reports/daily' => 'reports#daily'
  get 'reports/daily_all' => 'reports#daily_all'


  get 'management_console' => 'management_console#index'

  # lib
  get 'years/:year/makes' => 'makes#unique_makes'
  get 'years/:year/makes/:make/models' => 'models#unique_models'
  get 'zip_codes/:zip' => 'zip_codes#get_city_state'
  get 'validate_zip/:zip' => 'zip_codes#validate_zip'

  get "/*all", :constraints => {:all => /.*/}, to: 'ad_requests#new'

end
