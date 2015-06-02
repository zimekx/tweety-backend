class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  skip_before_filter :verify_authenticity_token

  before_filter :set_current_user

  def set_current_user
    @current_user = nil

    access_token = request.headers['X-Access-Token']
    if access_token.present?
      facebook_user = FacebookService.fetch_user(access_token)

      @current_user = User.find_by(facebook_id: facebook_user.id)
    end
  end

  def authenticate_user
    if @current_user.nil?
      head 403
    end
  end
end
