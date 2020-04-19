class RewardSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :point, :status, :sort, :username
  # belongs_to :user
  def username
    object.user.name
  end
end
