class GroupsController < ApplicationController
  layout "profile"
  before_action :auth_user

  def new
    @group = Group.new
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

  private
    def group_params
      params.require(:group).permit(:image, :name, :description)
    end

    def auth_user
      redirect_to root_path unless user_signed_in?
    end
end
