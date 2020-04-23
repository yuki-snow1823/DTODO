require 'rails_helper'

describe V1::UsersController , type: :request do
  describe 'Userコントローラーに関して' do

    context 'パラメーターが妥当な場合' do
      describe 'GET #index' do
        before do
          FactoryBot.create :user
        end

        it 'リクエストが成功すること' do
          get v1_users_path
          expect(response.status).to eq 200
        end

        it 'ユーザー名がjsonで返されること' do
          get v1_users_path
          json = JSON.parse(response.body)
          expect(json[0]["name"]).to eq "test-user"
        end
      end
    end

    context 'パラメーターが不正な場合' do
      describe 'GET #index' do
      # let!(:level_settitng) { LevelSetting.create(level:2, thresold:50) }
      before do
        FactoryBot.create :level_setting
        FactoryBot.create :user
      end
      # binding.pry
      
      it 'リクエストが成功すること' do
        get v1_users_path
        expect(response.status).to eq 200
        end

        it 'uidについて' do
          get v1_users_path params:{ uid: 123456 }
          json = JSON.parse(response.body)
          expect(json).to eq "test-user"
        end
      end
    end

  end
end
