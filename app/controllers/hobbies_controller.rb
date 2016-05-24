class HobbiesController < ApplicationController
  def create
    hobby = Hobby.find_by(name: params[:name])

    if hobby.nil?
      hobby = Hobby.create(name: params[:name])
    end

    add_hobby_to_user(hobby)

    redirect_to profile_path
  end

  private
    def add_hobby_to_user(hobby)
      if current_user.hobbies.find_by(name: params[:name]).nil?
        if current_user.hobbies.push(hobby)
          flash[:success] = "The hobby was added!"
        else
          flash[:error] = "The hobby was not added!"
        end
      else
        flash[:notice] = "The hobby was already added!"
      end
    end
end
