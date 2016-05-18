class SearchesController < ApplicationController
  layout "search"

  def search
    @lat = (params[:lat].nil?) ? "40.438683" : params[:lat]
    @lng = (params[:lng].nil?) ? "-3.681564" : params[:lng]
  end
end
