require_relative '../../domain/calc_user_level.rb'

class V1::UsersController < ApplicationController
    def index
      if params[:uid] 
        # firebaseの認証後、uidをもとに該当ユーザーを検索しています
        user = User.find_by(uid: params[:uid])

        if !user.present?
          render json: {}
        else 
          todos = user.todos.order(sort: "ASC")
          rewards = user.rewards.order(sort: "ASC")

          totalExp = user.experience_point
          user_level = CalcUserLevel.calc_user_level(user, totalExp)

          todo = {"title" => "","point" => ""}
          reward = {"title" => "","point" => ""}
          # 入力前のデータが削除されないようにする際に、エラーを起こさないように空のjsonを送っています

          render json: {user: user, reward: reward, todo: todo, todos: todos, rewards: rewards, untilPercentage: user_level[:until_percentage], untilLevel: user_level[:until_level]}
        end
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
