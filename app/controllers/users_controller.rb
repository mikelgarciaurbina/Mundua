class UsersController < ApplicationController
  layout "profile", only: [:profile, :change_password]
  before_action :auth_user

  def profile
    @user = current_user
    @technology = Technology.new
    @hobby = Hobby.new
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:success] = "Data changed successfully!"
      redirect_to profile_path
    else
      render "profile", layout: "profile"
    end
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(change_password_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      flash[:success] = "Password changed successfully!"
      redirect_to change_password_path
    else
      render "change_password", layout: "profile"
    end
  end

  def change_password
    @user = current_user
  end

  private

    def user_params
      params.require(:user).permit(:name, :lastname)
    end

    def change_password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end

    def auth_user
      redirect_to root_path unless user_signed_in?
    end
end
