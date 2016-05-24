require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  it "index" do
    get :index
    expect(response).to render_template("home")
  end
end
