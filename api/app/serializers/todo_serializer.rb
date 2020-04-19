class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :point, :sort
  belongs_to :user
end
