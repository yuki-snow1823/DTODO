require 'rails_helper'

describe V1::TodosController , type: :controller do
  
    describe 'createアクションについて' do
    it 'todoが期待される値を持つ' do
      todo = create(:todo)
      
      expect(todo).to be_valid
    end
  end

end
