class GroupsController < ApplicationController
  layout "profile"
  before_action :auth_user

  def new
    @group = Group.new
  end

  def edit
    @group = current_user.group
    if current_user.id != current_user.group.owner_id
      redirect_to profile_path
    end
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      current_user.group = @group
      current_user.save
      flash[:success] = "The group was created!"
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def show
    @group = current_user.group
  end

  def join_group
    group = Group.find(params[:group][:id])
    if group.friends_requests.blank?
      group.friends_requests = current_user.id
    else
      group.friends_requests += ", #{current_user.id}"
    end
    if group.save
      flash[:success] = "The request has sent!"
    else
      flash[:error] = "The request has not sent!"
    end
    redirect_to house_path(group.house)
  end

  def accept_user
    group = current_user.group
    user_to_accept = User.find(params[:user])
    if user_to_accept.nil?
      flash[:error] = "User not found!"
      redirect_to show_group_path
    else
      group.users.push(user_to_accept)
      group.remove_user_from_friends_requests(params[:user])
      flash[:success] = "User accept in group!"
      redirect_to show_group_path
    end
  end

  def reject_user
    group = current_user.group
    group.remove_user_from_friends_requests(params[:user])
    flash[:success] = "User reject!"
    redirect_to show_group_path
  end

  private
    def group_params
      params.require(:group).permit(:image, :name, :description)
    end

    def auth_user
      redirect_to root_path unless user_signed_in?
    end
end
