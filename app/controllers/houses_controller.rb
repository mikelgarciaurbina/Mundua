class HousesController < ApplicationController
  layout "profile", except: [:show]
  before_action :auth_user, except: [:show]

  def my_houses
    @houses = House.where("owner_id = ?", current_user)
  end

  def new
    @house = House.new
  end

  def show
    @house = House.find(params[:id])
  end

  def edit
    @house = House.find_by(id: params[:id])

    if current_user.id != @house.owner_id
      flash[:error] = "You don't have a permission!"
      redirect_to profile_path
    end
  end

  def update
    @house = House.find_by(id: params[:id])

    if @house.update(house_params)
      flash[:success] = "The house was update successfully!"
      redirect_to my_houses_path
    else
      flash.now[:error] = "An error has occurred!"
      render 'edit'
    end
  end

  def create
    @house = House.new(house_params)
    @house.owner_id = current_user.id

    if @house.save
      flash[:success] = "The house was created!"
      redirect_to my_houses_path
    else
      flash.now[:error] = "An error has occurred!"
      render 'new'
    end
  end

  def group_house
    @house = current_user.group.house
  end

  def join_house
    house = House.find_by(id: params[:house][:id])

    # if house.groups_requests.blank?
    #   house.groups_requests = current_user.id
    # else
    #   house.groups_requests += ", #{current_user.id}"
    # end

    house.groups_requests = house.groups_requests.to_s.split(', ')
      .push(current_user.group.id).join(', ')

    if house.save
      flash[:success] = "The request has sent!"
    else
      flash[:error] = "The request has not sent!"
    end
    
    redirect_to house_path(house)
  end

  def accept_group
    house = House.find_by(id: params[:id])
    group_to_accept = Group.find_by(id: params[:group])

    if group_to_accept.nil?
      flash[:error] = "Group not found!"
      redirect_to my_houses_path
    else
      house.groups.push(group_to_accept)
      House.remove_group_to_groups_requests_from_all_houses(params[:group])
      flash[:success] = "Group accept in house!"
      redirect_to my_houses_path
    end
  end

  def reject_group
    house = House.find_by(id: params[:id])
    house.remove_group_from_groups_requests(params[:group])
    flash[:success] = "Group reject!"
    redirect_to my_houses_path
  end

  def delete_group
    house = House.find_by(id: params[:id])

    if current_user.id == house.owner_id
      group = Group.find_by(id: params[:group])
      house.groups -= [group]
      flash[:success] = "Group deleted!"
    else
      flash[:error] = "You don't have a permission!"
    end

    redirect_to my_houses_path
  end

  def destroy
    house = House.find_by(id: params[:id])

    if current_user.id == house.owner_id
      house.delete
      flash[:success] = "House deleted!"
    else
      flash[:error] = "You don't have a permission!"
    end

    redirect_to my_houses_path
  end

  private
    def house_params
      params.require(:house).permit(:latitude, :longitude, :address, :rooms, :description, :image)
    end
end
