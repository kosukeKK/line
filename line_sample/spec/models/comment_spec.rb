require 'rails_helper'

descibe "" do
  let!(:user1) {create(:user)}
  let!(:user2) {create(:user)}
  let!(:tt) {create(:talk_thread, first_user_id: user1.id, second_user_id: user2.id)}
  let!(:comment) {create(:comment), talk_thread_id: tt.id, user_id: user1.id}
  subject {comment}

  it "" do
    is_expected.to be_valid
  end
end
