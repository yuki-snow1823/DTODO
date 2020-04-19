class V1::UsersController < ApplicationController
    def index
      if params[:uid] 
        user = User.find_by(uid: params[:uid])
        todos = user.todos.order(sort: "ASC")
        render json: {user: user, todos: todos}
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
        if reward.errors.present?
          # binding.pry
          render json: {error_msg: reward.errors.full_messages}, status: :unprocessable_entity
        end
        render json: user.errors, status: :unprocessable_entity
      end
    end

    private
      def user_params
        params.require(:user).permit(:email, :uid, :name)
      end
end
