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
        # v1_todos_pathだとうまくいかない
          expect(response.status).to eq 422
      end

      it 'Todoが登録されないこと' do
        expect do
          post v1_todos_path, params: { todo: FactoryBot.attributes_for(:todo, :invalid) }
        end.to_not change(Todo, :count)
      end

    end
  end
end
