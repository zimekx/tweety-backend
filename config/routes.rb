Rails.application.routes.draw do

  scope '/api/' do
    with_options defaults: {format: :json} do |r|
      r.resources :events, except: [:new, :edit]
      r.resources :users, except: [:new, :edit] do
        get :validate, on: :collection
      end
      r.resources :comments, except: [:new, :edit]
    end
  end
end
