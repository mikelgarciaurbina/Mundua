require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  controller do
    def user_signed_in?
      true
    end
  end
  let(:current_user) { FactoryGirl.build(:user) }

  it "renders the profile template" do
    get :new
    expect(response).to render_template("profile")
  end

  # it 'creates the group' do
  #   login_as current_user
  #   post :create, group: FactoryGirl.attributes_for(:group)
  #   expect(Group.count).to eq(1)
  # end

  # it 'redirects to the "show" action for the new group' do
  #   login_as current_user
  #   post :create, group: FactoryGirl.attributes_for(:group)
  #   expect(response).to redirect_to Group.first
  # end

  # it "renders the profile template" do
  #   login_as current_user
  #   get :show
  #   expect(response).to render_template("profile")
  # end
end
