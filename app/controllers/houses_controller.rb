class HousesController < ApplicationController
  layout "profile", except: [:show]
  before_action :auth_user, except: [:show]

  def myHouses
    @houses = House.where("owner_id = ?", current_user)
  end

  def new
    @house = House.new
  end

  def show
    @house = House.find(params[:id])
    render layout: "search"
  end

  def create
    @house = House.new(house_params)
    @house.owner_id = current_user.id
    if @house.save
      flash[:success] = "The house was created!"
      redirect_to my_houses_path
    else
      render 'new'
    end
  end

  def group_house
    @house = current_user.group.house
  end

  def join_house
    house = House.find(params[:house][:id])
    if house.groups_requests.nil?
      house.groups_requests = current_user.id
    else
      house.groups_requests += ", #{current_user.id}"
    end
    house.save
    flash[:success] = "The request has sent!"
    redirect_to house_path(house)
  end

  private
    def house_params
      params.require(:house).permit(:latitude, :longitude, :address, :rooms, :description, :image)
    end

    def auth_user
      redirect_to root_path unless user_signed_in?
    end
end
