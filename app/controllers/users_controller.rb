class UsersController < ApplicationController
  layout "profile", only: [:profile]
  before_action :auth_user

  def profile
    @user = current_user
  end

  def update
  end

  private
    def auth_user
      redirect_to root_path unless user_signed_in?
    end
end
