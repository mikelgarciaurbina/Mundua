class Api::V1::NomadlistController < ApplicationController
  def index
    uri = URI('https://nomadlist.com/api/v2/list/cities')
    res = Net::HTTP.get(uri)
    render json: res
  end
end