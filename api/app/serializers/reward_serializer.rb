class RewardSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :point, :status
  belongs_to :user
end
