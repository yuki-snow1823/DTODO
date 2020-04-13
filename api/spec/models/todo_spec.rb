require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'Todoを登録できる' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'Todoを追加' do
      user = @user
      todo = Todo.new(
        user_id: 1,
        title: "test",
        point: 1,
      )
      expect(user).to be_valid
    end

    it 'Todoを削除' do
      user = @user
      todo =FactoryBot.create(:todo)
      todo.destroy
      expect{Todo.find(1)}.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
