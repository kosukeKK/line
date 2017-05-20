class Api::V1::CommentsController < ApplicationController
  def index
    @data = Comment.where(user_id: current_user.id)
  end

  def create
    @comment = Comment.create(comment_params)
    render :show, status: :created
  end

  private

  def comment_params
    binding.pry
    params.permit(:text, :user_id)
  end
end
