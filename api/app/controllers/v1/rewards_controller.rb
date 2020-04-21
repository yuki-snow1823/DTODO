require_relative '../../domain/user_level.rb'

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
      # binding.pry
      reward.update(reward_params)
      render json: reward
    end

    def destroy
      reward = Reward.find(params[:id])
      if reward.destroy
        render json: reward
      end
    end

    def complete
      reward = Reward.find(params[:id])
      # binding.pry
      reward.update(status: true)
      user = User.find(reward.user_id)
      losepoint = user.point.to_i
      losepoint -= reward.point
      user.point = losepoint
      user.update(point: losepoint)
      todos = user.todos.order(sort: "ASC")
      totalExp = user.experience_point
      user_level = calc_user_level(user, totalExp)
      render json: {user: user, todos: todos, reward: reward, untilPercentage: user_level[:until_percentage], untilLevel: user_level[:until_level]}
      # render json: {reward: reward, user: user}
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
