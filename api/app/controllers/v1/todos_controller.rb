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
      # ここに飛ばすことはできた。
        todo = Todo.find(params[:id])
        
        if todo.destroy
            render json: todo
            # render json: {posts: @posts, user: @user }もしかするとこう
        end
        # ユーザーのパラメーター取得をしないと
    end

    private
      def todo_params
        params.require(:todo).permit(:title, :user_id, :point)
      end
end
