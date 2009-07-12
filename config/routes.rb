ActionController::Routing::Routes.draw do |map|
  map.resources :games

  map.resources :events

  if RAILS_ENV == 'production' then
    map.root :controller => "under_development", :action => "index"
  else
    map.root :controller => "datebook", :action => "index"
  end

  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end