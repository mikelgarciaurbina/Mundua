class SearchesController < ApplicationController
  layout "search"

  def search
    # @lat = params[:lat]
    # @lng = params[:lng]
    @lat = "40.438683"
    @lng = "-3.681564"
  end
end
