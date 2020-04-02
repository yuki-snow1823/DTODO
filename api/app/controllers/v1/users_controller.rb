class V1::UsersController < ApplicationController
  def index
    if params[:uid] 
      @user = User.find_by(uid: params[:uid])
      render json: @user
    else 
      @users = User.all
      render json: @users
    end
  end

    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end

    private
      def user_params
        params.require(:user).permit(:email, :uid, :name)
      end
end
