class V1::RewardsController < ApplicationController
    def create
      reward = Reward.new(reward_params)
      if reward.save
        render json: reward, status: :created
      else
        render json: reward.errors, status: :unprocessable_entity
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
      # ポイントを加算to_iはいずれ消す
      # なぜかキャッシュから読み込むから変数に入れる
      render json: {reward: reward, user: user}
    end

    private
      def reward_params
        params.require(:reward).permit(:title, :user_id, :point, :status)
      end
end
