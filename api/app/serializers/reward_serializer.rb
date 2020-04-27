class RewardSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :point, :status, :sort
  belongs_to :user
end
