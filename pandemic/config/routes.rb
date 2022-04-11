Rails.application.routes.draw do
      get :start, to: 'games#start'
      get :infect, to: 'games#infect'
end
