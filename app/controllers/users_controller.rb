class UsersController < ApplicationController
  layout "profile", only: [:profile, :change_password]
  before_action :auth_user

  def profile
    @user = current_user
    @technology = Technology.new
    @hobby = Hobby.new
  end

  def update
    @user = User.find_by(id: current_user.id)

    if @user.update(user_params)
      flash[:success] = "Data changed successfully!"
      redirect_to profile_path
    else
      @technology = Technology.new
      @hobby = Hobby.new
      render "profile", layout: "profile"
    end
  end

  def update_password
    @user = User.find_by(id: current_user.id)

    if @user.update_with_password(change_password_params)
      sign_in @user, :bypass => true
      flash[:success] = "Password changed successfully!"
      redirect_to change_password_path
    else
      flash.now[:error] = "An error has occurred!"
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
end
