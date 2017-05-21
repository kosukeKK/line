class Api::V1::CommentsController < ApplicationController
  before_action :thread_find_or_create
  def index
    @data = Comment.where(talk_thread_id: params["talk_thread_id"]).all
  end

  def create
    @comment = Comment.create(comment_params)
    render :show, status: :created
  end

  private
  def find_to_user_id
    user_id = /to_user=/.match(request.referer).post_match
    User.where(id: user_id).first&.id
  end

  def comment_params
    {user_id: params["user_id"], text: params["text"], talk_thread_id: params["talk_thread_id"]}
  end

  def thread_find_or_create
    if to_user_id = find_to_user_id.presence
      talk_thread = TalkThread.where(:first_user_id.in => [to_user_id, current_user.id], :second_user_id.in => [to_user_id, current_user.id]).first
      params["talk_thread_id"] = talk_thread ? talk_thread.id : create_talk_thread(to_user_id)
    else
      # params["talk_thread_id"] = admin
    end
  end

  def create_talk_thread(to_user_id)
    talk_thread = TalkThread.new do |t|
      t.first_user_id = current_user.id
      t.second_user_id = to_user_id
    end
    talk_thread.save
    talk_thread.id
  end
end
