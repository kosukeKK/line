class Api::V1::CommentsController < ApplicationController
  def index
    if to_user_id = find_to_user_id.presence
      @data = Comment.where(:user_id.in => [to_user_id, current_user.id]).all
    end
  end

  def create
    @comment = Comment.create(comment_params)
    render :show, status: :created
  end

  private
  def find_to_user_id
    /to_user=/.match(request.referer).post_match
  end

  def comment_params
    params.permit(:user_id, :text)
  end
end
