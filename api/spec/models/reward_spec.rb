require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe '動作確認のテスト' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'Rewardを追加' do
      user = @user
      reward = Reward.new(
        user_id: 1,
        title: "test",
        point: 1,
      )
      expect(reward).to be_valid
    end

    it 'Rewardを削除' do
      user = @user
      reward =FactoryBot.create(:reward)
      reward.destroy
      expect{Reward.find(1)}.to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'Rewardのtitleを編集' do
      user = @user
      reward =FactoryBot.create(:reward)
      reward.update(title: "new-title")
      expect(reward.title).to eq "new-title"
    end

    it 'Rewardのpointを編集' do
      user = @user
      reward =FactoryBot.create(:reward)
      reward.update(point: 2)
      expect(reward.point).to eq 2
    end
  
  end

  describe 'バリデーションのテスト' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'titleが空の場合保存されない' do
      user = @user
      reward = Reward.new(
        user_id: 1,
        title: "",
        point: 1,
      )
      reward.valid?
      expect(reward.errors[:title]).to include("を入力してください")
    end

    it 'titleが20文字の以上の場合保存されない' do
      user = @user
      reward = Reward.new(
        user_id: 1,
        title: "テストテストテストテストテストテストテストテストテストテスト",
        point: 1,
      )
      reward.valid?
      expect(reward.errors[:title]).to include("は20文字以内で入力してください")
    end

    it 'pointが空の場合保存されない' do
      user = @user
      reward = Reward.new(
        user_id: 1,
        title: "テスト",
        point: "",
      )
      reward.valid?
      expect(reward.errors[:point]).to include("を入力してください")
    end
  
  end
end
