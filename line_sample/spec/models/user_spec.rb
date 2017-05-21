require 'rails_helper'

describe "ユーザーが作られているか" do
  let!(:user) {create(:user)}
  subject {user}
  it "ユーザ作られている" do
    is_expected.to be_valid
  end
end
