require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  controller do
    def user_signed_in?
      true
    end
  end

  it "new" do
    get :new
    expect(response).to render_template("profile")
  end

  it 'create' do
    login_with create( :user )
    post :create, group: attributes_for(:group, :owner_id => 1)
    expect(Group.all.count).to eq(1)
  end
end
