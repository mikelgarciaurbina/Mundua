require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  it 'search' do
    login_with create( :user )
    post :search, { lat: "324423", lng: "2332" }
    expect(response).to render_template("application")
  end
end
