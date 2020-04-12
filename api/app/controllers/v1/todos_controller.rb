class V1::TodosController < ApplicationController
    def create
      todo = Todo.new(todo_params)
      if todo.save
        render json: todo, status: :created
      else
        # render json: todo.errors, status: :unprocessable_entity
        # binding.pry
        if todo.errors.full_messages.first == "Title can't be blank"
          render json: {error_msg: "タイトルを入力してください"}, status: :unprocessable_entity
          # statusをcatchで拾っている/unp...=modelのバリデーションで出しているステータス
        else 
          render json: todo.errors, status: :unprocessable_entity
          # render json: {error_msg: "error2", status: 422}
        end
        # render json: {error_msg: "error", status: 422}
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
      if levelSetting.present? && levelSetting.thresold <= user.experience_point
        user.level = user.level + 1
        user.update(level: user.level)
      end

      if todo.destroy
        render json: {todo: todo, user: user}
      end
    end

    private
      def todo_params
        params.require(:todo).permit(:title, :user_id, :point)
      end
end
