require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe "ユーザーが作られているか" do
  let!(:user) {create(:user)}
  subject {user}
  it "ユーザ作られている" do
    is_expected.to be_valid
  end
end
