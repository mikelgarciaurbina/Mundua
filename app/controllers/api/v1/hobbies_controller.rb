class Api::V1::HobbiesController < ApplicationController
  def index
    render json: Hobby.all
  end
end