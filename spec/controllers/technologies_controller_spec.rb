require 'rails_helper'

RSpec.describe TechnologiesController, type: :controller do
  controller do
    def user_signed_in?
      true
    end
  end

  it 'create' do
    login_with create( :user )
    post :create, name: "test"
    expect(Technology.all.count).to eq(1)
  end
end
