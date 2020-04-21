class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :point, :level, :experience_point, :todo_tour, :reward_tour
  has_many :todos 
  has_many :rewards
end
