require_relative '../../domain/calc_user_level.rb'

class V1::RewardsController < ApplicationController

    def create
      reward = Reward.new(reward_params)
      if reward.save
        render json: reward, status: :created
      else
        if reward.errors.present?
          render json: {error_msg: reward.errors.full_messages}, status: :unprocessable_entity
        else 
          render json: reward.errors, status: :unprocessable_entity
        end
      end
    end

    def update
      reward = Reward.find(params[:id])
      reward.update(reward_params)
      render json: reward
    end

    def destroy
      reward = Reward.find(params[:id])
      
      # チュートリアルを繰り返し発生させない処理
      user = User.find(reward.user_id)

      # テストユーザーならチュートリアルを毎回行う
      if user.email != "testtest777@gmail.com"
        user.update(todo_tour: false, reward_tour: false)
      end

      if reward.destroy
        render json: {reward: reward, user: user}
      end
    end

    def complete
      reward = Reward.find(params[:id])
      user = User.find(reward.user_id)

      if user.point < reward.point
        render json: {error_msg: ["タスクポイントが足りません"]}, status: :unprocessable_entity
      else
        losepoint = user.point.to_i
        losepoint -= reward.point
        user.point = losepoint
        
        reward.update(status: true)
        user.update(point: losepoint)
        
        todos = user.todos.order(sort: "ASC")
        totalExp = user.experience_point
        user_level = CalcUserLevel.calc_user_level(user, totalExp)
        
        render json: {user: user, todos: todos, reward: reward, untilPercentage: user_level[:until_percentage], untilLevel: user_level[:until_level]}
      end
    end

    def sort
      params[:reward].each_with_index do |t,i|
        @reward = Reward.find(t[:id])
        @reward.update( sort: i )
      end
      render json: {result: "ok"}
    end

    private
      def reward_params
        params.require(:reward).permit(:title, :user_id, :point, :status, :sort)
      end
end
