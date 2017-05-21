require 'rails_helper'

describe "Threadがないとき" do
  let!(:user1) {create(:user, email: "examplesamfgassdfsdfdsdfgdpleuserfsss@gmail.co.jp")}
  let!(:user2) {create(:user, email: "examplesampleusesadasdrfsss@gmail.co.jp")}
  let!(:tt) {create(:talk_thread, first_user_id: user1.id, second_user_id: user2.id)}
  subject {tt}
  it "Threadを起ち上げる" do
    is_expected.to be_valid
  end
end
