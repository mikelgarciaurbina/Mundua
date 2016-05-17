class GroupsController < ApplicationController
  layout "page", only: [:show]
  before_action :auth_user

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      current_user.group = @group
      flash[:success] = "The group was created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  private
    def group_params
      params.require(:group).permit(:image, :name, :description)
    end

    def auth_user
      redirect_to root_path unless user_signed_in?
    end
end
