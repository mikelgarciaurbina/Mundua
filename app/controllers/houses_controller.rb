class HousesController < ApplicationController
  layout "profile"
  before_action :auth_user

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    @house.owner_id = current_user.id
    if @house.save
      flash[:success] = "The house was created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @house = House.find(params[:id])
  end

  private
    def house_params
      params.require(:house).permit(:latitude, :longitude, :address, :rooms, :description, :image)
    end

    def auth_user
      redirect_to root_path unless user_signed_in?
    end
end
