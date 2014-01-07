Celengin::Application.routes.draw do
  
  get "savings/index"
  root 'home#index'
  devise_for :users, :path => '', :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'signup' }
  get   "dashboard/index"
  resources :target_savings, only: [:index] do #, :events
    resources :events, only: [:index] 
  end
  # resources :posts do
  #   resources :comments, only: [:index, :new, :create]
  # end
  post  "events" => "events#create"
  post  "target_savings" => "savings#create"
end
