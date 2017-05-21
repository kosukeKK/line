require 'rails_helper'

describe "TalkThreadにコメントがあるとき" do
  let!(:user1) {create(:user, email: "examplesamfgdfgdpleuserfsss@gmail.co.jp")}
  let!(:user2) {create(:user, email: "examplesampleuserfsss@gmail.co.jp")}
  let!(:tt) {create(:talk_thread, first_user_id: user1.id, second_user_id: user2.id)}
  let!(:comment) {create(:comment, talk_thread_id: tt.id, user_id: user1.id)}
  subject {comment}

  it "コメントを返す" do
    is_expected.to be_valid
  end
end
