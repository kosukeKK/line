class TopController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.where(:id.nin => [current_user&.id])
  end

  def show
    to_user_ids = has_tt_user_ids
    @users = User.where(:id.in => to_user_ids)
  end

  private
    def has_tt_user_ids
      tt_ids = current_user.comment.pluck(:talk_thread_id).uniq
      TalkThread.where(:id.in => tt_ids).pluck(:first_user_id, :second_user_id).flatten.uniq.delete_if {|user_id| user_id == current_user.id }
    end
end
