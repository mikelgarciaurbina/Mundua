class Api::V1::HousesController < ApplicationController
  def index
    coordinates = params[:coordinates].split(", ")
    houses = House.where("latitude BETWEEN #{coordinates[1]} AND " +
      "#{coordinates[3]} AND longitude BETWEEN " +
      "#{coordinates[0]} AND #{coordinates[2]}")
    render json: houses
  end
end