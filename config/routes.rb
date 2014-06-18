Rails.application.routes.draw do
  resources :calendar_lines, :path => 'bonuses'

  root to: "calendar_lines#index"
end
