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

    private
      def todo_params
        params.require(:todo).permit(:title, :user_id)
      end
end
