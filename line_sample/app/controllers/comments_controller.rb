class CommentsController < ApplicationController
  before_action :logged_in_user, :mistake_url_is_redirext_root

  def index
  end

  private
    def mistake_url_is_redirext_root
      if User.where(id: params["to_user"]).first.nil?
        redirect_to root_path, alert: 'URLが違います'
      end
    end
end
