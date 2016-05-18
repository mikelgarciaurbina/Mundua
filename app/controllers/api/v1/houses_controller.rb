class Api::V1::HousesController < ApplicationController
  def index
    houses = House.where("latitude BETWEEN #{params[:coordinates][1]} AND " +
      "#{params[:coordinates][3]} AND longitude BETWEEN " +
      "#{params[:coordinates][0]} AND #{params[:coordinates][2]}")
    render json: houses
  end
end