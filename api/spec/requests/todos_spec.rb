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
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        put :update, params: { id: takashi, user: FactoryBot.attributes_for(:satoshi) }
        expect(response.status).to eq 302
      end

      it 'ユーザー名が更新されること' do
        expect do
          put :update, params: { id: takashi, user: FactoryBot.attributes_for(:satoshi) }
        end.to change { User.find(takashi.id).name }.from('Takashi').to('Satoshi')
      end

      it 'リダイレクトすること' do
        put :update, params: { id: takashi, user: FactoryBot.attributes_for(:satoshi) }
        expect(response).to redirect_to User.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        put :update, params: { id: takashi, user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.status).to eq 200
      end

      it 'ユーザー名が変更されないこと' do
        expect do
          put :update, params: { id: takashi, user: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User.find(takashi.id), :name)
      end
  end
end
