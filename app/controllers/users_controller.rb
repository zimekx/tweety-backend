class UsersController < ApplicationController
  def index
    @users = User.all

    render json: {users: @users}
  end

  def show
    @user = User.find(params[:id])

    render json: {user: @user}
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: {user: @user}, status: :ok
    else
      render json: {errors: @user.errors.messages}, status: :unprocessable_entity
    end
  end

  def validate
    if @current_user.present?
      head :ok
    else
      head :not_found
    end
  end

  def user_params
    facebook_user = FacebookService.fetch_user(request.headers['X-Access-Token'])

    {
      email: facebook_user.id, #facebook_user.email,
      name: facebook_user.name,
      login: params[:user][:login],
      type: params[:user][:type] || :commenter
    }
  end
end