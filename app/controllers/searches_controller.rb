class SearchesController < ApplicationController
  def search
    @lat = (params[:lat].blank?) ? "40.438683" : params[:lat]
    @lng = (params[:lng].blank?) ? "-3.681564" : params[:lng]
  end
end
