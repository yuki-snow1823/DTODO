require 'rails_helper'

describe V1::RewardsController , type: :request do

  describe 'POST #create' do
    let!(:user){ create(:user) }
    let!(:reward){ create(:reward) }
    context 'パラメーターが妥当な場合' do
      it 'リクエストが成功する' do
        post v1_rewards_path, params: { reward: FactoryBot.attributes_for(:reward) }
          expect(response.status).to eq 201
      end

      it 'Rewardが登録される' do
        expect do
          post v1_rewards_path, params: { reward: FactoryBot.attributes_for(:reward) }
        end.to change(Reward, :count).by(1)
      end
    end
    
    context 'パラメーターが不正な場合' do
      it 'リクエストが成功する' do
        post v1_rewards_path, params: { reward: FactoryBot.attributes_for(:reward, :invalid) }
          expect(response.status).to eq 422
      end

      it 'Rewardが登録されないこと' do
        expect do
          post v1_rewards_path, params: { reward: FactoryBot.attributes_for(:reward, :invalid) }
        end.to_not change(Reward, :count)
      end

    end
  end

  describe 'PATCH #update' do
      let!(:user){ create(:user) }
      let!(:reward){ create(:reward) }
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        patch v1_reward_path(id: 1), params: { id:1, reward: FactoryBot.attributes_for(:reward)}
        expect(response.status).to eq 200
      end

      it 'タイトルが更新されること' do
        expect do
          patch v1_reward_path(id: 1), params: { id:1, reward: FactoryBot.attributes_for(:reward_changed) }
        end.to change { Reward.find(1).title }.from('test').to('changed')
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        patch v1_reward_path(id: 1), params: { id:1, reward: FactoryBot.attributes_for(:reward_changed, :invalid) }
        expect(response.status).to eq 422
      end

      it 'タイトルが変更されないこと' do
        expect do
          patch v1_reward_path(id: 1), params: { id:1, reward: FactoryBot.attributes_for(:reward, :invalid) }
        end.to_not change(Reward.find(1), :title)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user){ create(:user) }
    let!(:reward) { FactoryBot.create :reward }

    it 'リクエストが成功すること' do
      delete v1_reward_path(id: 1)
      expect(response.status).to eq 200
    end

    it 'ユーザーが削除されること' do
      expect do
        delete v1_reward_path(id: 1)
      end.to change(Reward, :count).by(-1)
    end

  end
end
