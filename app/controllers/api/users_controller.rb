module Api
  class Api::UsersController < Api::ApiController
    before_action :auth_and_set_user, only: [:update, :destroy]

    def index
      @users = User.all
      unless @users.empty?
        render json: @users, each_serializer: UserSerializer
      else
        error(404, 'There are literally no users. You have the power to change that: go sign up!')
      end
    end

    def show
      @user = User.find_by(id: params[:id])
      if @user.present?
        render json: @user, serializer: UserSerializer
      else
        error(404, 'No user found with that id')
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      head :no_content
    end

    private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
  end
end
