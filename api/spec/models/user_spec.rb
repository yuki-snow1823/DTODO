RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end
  it "必要項目が存在すれば有効" do
    expect(@user).to be_valid
  end

  it "nameがないと無効" do
    @user.name = ""
    expect(@user).not_to be_valid
  end

  it "emailがないと無効" do
    @user.email = ""
    expect(@user).not_to be_valid
  end

  it "uidがないと無効" do
    @user.uid = ""
    expect(@user).not_to be_valid
  end


end
