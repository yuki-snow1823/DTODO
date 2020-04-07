class RewardSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :point
  belongs_to :user
end
