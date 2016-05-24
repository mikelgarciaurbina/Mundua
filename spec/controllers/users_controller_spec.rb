require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it "profile" do
    login_with create( :user )
    get :profile
    expect(response).to render_template("profile")
  end

  it "change_password" do
    login_with create( :user )
    get :change_password
    expect(response).to render_template("profile")
  end
end
