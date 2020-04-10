require 'rails_helper'

describe V1::TodosController , type: :controller do
  
    describe 'createアクションについて' do
    it 'titleとpointが設定してある場合、実行されるか' do
      todo = FactoryBot.create(:todo)
      

      expect(todo).to be_valid
    end
  end

end
