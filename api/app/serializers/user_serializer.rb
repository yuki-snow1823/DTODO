class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :point
  has_many :todos 
  has_many :rewards
end
