class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :point, :sort, :username
  # belongs_to :user

  def username
    object.user.name
  end
end
