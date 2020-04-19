class V1::TodosController < ApplicationController
    def create
      todo = Todo.new(todo_params)
      if todo.save
        render json: todo, status: :created
      else
        if todo.errors.present?
          # binding.pry
          render json: {error_msg: todo.errors.full_messages}, status: :unprocessable_entity
        else 
          render json: todo.errors, status: :unprocessable_entity
        end
      end
    end

    def update
      todo = Todo.find(params[:id])
      todo.update(todo_params)
      render json: todo
    end

    def destroy
      todo = Todo.find(params[:id])
      if todo.destroy
        render json: todo
      end
    end

    def complete
      todo = Todo.find(params[:id])
      user = User.find(todo.user_id)

      totalPoint = user.point.to_i
      totalPoint += todo.point
      user.point = totalPoint

      totalExp = user.experience_point
      totalExp += todo.point
      user.experience_point = totalExp
      user.update(point: totalPoint,experience_point: totalExp)
      # ポイントを加算to_iはいずれ消す
      # なぜかキャッシュから読み込むから変数に入れる
      levelSetting = LevelSetting.find_by(level: user.level + 1)
      binding.pry
      if levelSetting.present? && levelSetting.thresold <= user.experience_point
        user.level = user.level + 1
        user.update(level: user.level)
        totalExp = 0
      end

      untilPoint = totalExp.quo(levelSetting.thresold).to_f.round(2)*100

      if todo.destroy
        render json: {todo: todo, user: user, exp: untilPoint}
      end
    end

    def sort
      params[:todo].each_with_index do |t,i|
        @todo = Todo.find(t[:id])
        @todo.update( sort: i )
      end
      render json: {result: "ok"}
    end

    private
      def todo_params
        params.require(:todo).permit(:id, :title, :user_id, :point, :sort)
      end
end
