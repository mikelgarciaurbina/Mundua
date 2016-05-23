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
    if group.friends_requests.nil?
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

  private
    def group_params
      params.require(:group).permit(:image, :name, :description)
    end

    def auth_user
      redirect_to root_path unless user_signed_in?
    end
end
