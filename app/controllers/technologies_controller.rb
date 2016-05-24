class TechnologiesController < ApplicationController
  def create
    technology = Technology.find_by(name: params[:name])

    if technology.nil?
      technology = Technology.create(name: params[:name])
    end

    add_technology_to_user(technology)
    
    redirect_to profile_path
  end

  private
    def add_technology_to_user(technology)
      if current_user.technologies.find_by(name: params[:name]).nil?
        if current_user.technologies.push(technology)
          flash[:success] = "The technology was added!"
        else
          flash[:error] = "The technology was not added!"
        end
      else
        flash[:notice] = "The technology was already added!"
      end
    end
end
