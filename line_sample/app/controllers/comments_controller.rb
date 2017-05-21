class CommentsController < ApplicationController
  before_action :logged_in_user

  def index
    @to_user = find_thread_to_user
    mistake_url_is_redirext_root unless @to_user
  end

  private
    def mistake_url_is_redirext_root
      redirect_to root_path, alert: 'ユーザーが存在しません'
    end

    def find_thread_to_user
      User.where(id: params["to_user"]).first.presence
    end
end
