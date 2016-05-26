class GroupsController < ApplicationController
  layout "profile"
  before_action :auth_user

  def new
    @group = Group.new
  end

  def edit
    @group = current_user.group

    if current_user.id != current_user.group.owner_id
      flash[:error] = "You don't have a permission!"
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
      redirect_to show_group_path
    else
      flash.now[:error] = "An error has occurred!"
      render 'new'
    end
  end

  def update
    @group = current_user.group

    if @group.update(group_params)
      flash[:success] = "The group was update successfully!"
      redirect_to show_group_path
    else
      flash.now[:error] = "An error has occurred!"
      render 'edit'
    end
  end

  def show
    @group = current_user.group
  end

  def join_group
    group = Group.find_by(id: params[:group][:id])

    group.friends_requests = group.friends_requests.to_s.split(', ')
      .push(current_user.id).join(', ')
    
    if group.save
      flash[:success] = "The request has sent!"
    else
      flash[:error] = "The request has not sent!"
    end

    redirect_to house_path(group.house)
  end

  def accept_user
    group = current_user.group
    user_to_accept = User.find_by(id: params[:user])

    if user_to_accept.nil?
      flash[:error] = "User not found!"
      redirect_to show_group_path
    else
      group.users.push(user_to_accept)
      Group.remove_user_to_friends_requests_from_all_groups(params[:user])
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

  def delete_user
    if current_user.id == current_user.group.owner_id
      group = current_user.group
      user = User.find_by(id: params[:user])

      if user.id == current_user.group.owner_id
        flash[:error] = "This user is admin!"
      else
        group.users -= [user]
        flash[:success] = "User deleted!"
      end
    else
      flash[:error] = "You don't have a permission!"
    end

    redirect_to show_group_path
  end

  def destroy
    group = Group.find_by(id: params[:id])

    if current_user.id == group.owner_id
      group.delete
      flash[:success] = "Group deleted!"
    else
      flash[:error] = "You don't have a permission!"
    end

    redirect_to new_group_path
  end

  private
    def group_params
      params.require(:group).permit(:image, :name, :description)
    end
end
