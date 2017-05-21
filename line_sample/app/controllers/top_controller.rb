class TopController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.where(:id.nin => [current_user&.id])
  end
end
