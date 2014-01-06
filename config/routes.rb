Celengin::Application.routes.draw do
  
  get "savings/index"
  root 'home#index'
  devise_for :users, :path => '', :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'signup' }
  get   "dashboard/index"
  resources :examples#, :events
  post  "events" => "events#create"
  post  "target_savings" => "savings#create"
end
