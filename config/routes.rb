Rails.application.routes.draw do
  resources :calendar_lines, :path => 'bonuses'

  root to: "calendar_lines#index"

  # For catching exceptions
  #get '*unmatched_route', :to => 'application#raise_not_found'

end
