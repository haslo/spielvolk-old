ActionController::Routing::Routes.draw do |map|
  map.resources :games

  map.resources :events

  map.root :controller => "home", :action => "index"

  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end