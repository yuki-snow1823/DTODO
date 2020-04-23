require 'rails_helper'

describe V1::UsersController , type: :request do
  describe 'GET #index' do
    context 'パラメーターが妥当な場合' do
      before do
        FactoryBot.create :level_setting
        FactoryBot.create :user
      end
      
      it 'リクエストが成功すること' do
         get v1_users_path
         expect(response.status).to eq 200
      end
      
      it 'jsonで正しいユーザーが返されること' do
        get v1_users_path params:{ uid: 123456 }
        json = JSON.parse(response.body)
        expect(json["user"]["name"]).to eq "test-user"
      end

    end
    
    context 'パラメーターが不正な場合' do
      before do
        FactoryBot.create :user
      end
      
      it 'リクエストが成功すること' do
        get v1_users_path
        expect(response.status).to eq 200
      end
      
      it 'jsonがnilで返されること' do
        get v1_users_path params:{ uid: 99999 }
        json = JSON.parse(response.body)
        expect(json["user"]).to eq nil
      end
    end
  end

  describe 'POST #create' do
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post v1_users_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response.status).to eq 201
      end

      it 'ユーザーが登録されること' do
        expect do
          post v1_users_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
     end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post v1_users_path, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.status).to eq 422
      end

      it 'ユーザーが登録されないこと' do
        expect do
          post v1_users_path, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User, :count)
      end
    end
  end

end
