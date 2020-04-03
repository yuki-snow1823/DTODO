class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :point
  has_many :todos 
end
