require 'rails_helper'

describe V1::TodosController , type: :request do

  describe 'POST #create' do
    context 'パラメーターが妥当な場合' do
      it 'リクエストが成功する' do
        post v1_todos_path, params: { todo: FactoryBot.attributes_for(:todo) }
          expect(response.status).to eq 201
      end

      it 'Todoが登録される' do
        expect do
          post v1_todos_path, params: { todo: FactoryBot.attributes_for(:todo) }
        end.to change(Todo, :count).by(1)
      end
    end
    
    context 'パラメーターが不正な場合' do
      it 'リクエストが成功する' do
        post v1_todos_path, params: { todo: FactoryBot.attributes_for(:todo, :invalid) }
          expect(response.status).to eq 422
      end

      it 'Todoが登録されないこと' do
        expect do
          post v1_todos_path, params: { todo: FactoryBot.attributes_for(:todo, :invalid) }
        end.to_not change(Todo, :count)
      end

    end
  end

  describe 'PATCH #update' do
      let!(:todo){ create(:todo) }
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        patch v1_todo_path(id: 1), params: { id:1, todo: FactoryBot.attributes_for(:todo)}
        expect(response.status).to eq 200
      end

      it 'タイトルが更新されること' do
        expect do
          patch v1_todo_path(id: 1), params: { id:1, todo: FactoryBot.attributes_for(:todo_changed) }
        end.to change { Todo.find(1).title }.from('test').to('changed')
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        patch v1_todo_path(id: 1), params: { id:1, todo: FactoryBot.attributes_for(:todo_changed, :invalid) }
        expect(response.status).to eq 422
      end

      it 'タイトルが変更されないこと' do
        expect do
          patch v1_todo_path(id: 1), params: { id:1, todo: FactoryBot.attributes_for(:todo, :invalid) }
        end.to_not change(Todo.find(1), :title)
      end
    end
  end
end
