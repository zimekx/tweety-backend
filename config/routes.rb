Rails.application.routes.draw do

  scope '/api/' do
    with_options defaults: {format: :json} do |r|
      r.resources :events, except: [:new, :edit]
    end
  end
end
