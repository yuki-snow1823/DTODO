class AddTodoTourToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :todo_tour, :boolean, default: true, null: false
  end
end
