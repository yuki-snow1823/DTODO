class V1::TodosController < ApplicationController
    def create
      todo = Todo.new(todo_params)
      if todo.save
        render json: todo, status: :created
      else
        render json: todo.errors, status: :unprocessable_entity
      end
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
      getpoint = user.point.to_i
      getpoint += todo.point
      user.point = getpoint
      user.update(point: getpoint)
      # ポイントを加算to_iはいずれ消す
      # なぜかキャッシュから読み込むから変数に入れる
        if todo.destroy
            render json: {todo: todo, user: user}
        end
    end

    private
      def todo_params
        params.require(:todo).permit(:title, :user_id, :point)
      end
end
