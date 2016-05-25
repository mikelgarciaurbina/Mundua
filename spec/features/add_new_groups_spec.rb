require 'rails_helper'

RSpec.feature "add_new_groups", type: :feature do
  it "add new group" do
    user = create(:user)
    login_as user, scope: :user

    visit new_group_path
    login_as user, scope: :user

    fill_in "group[name]", with: "Ironhack"
    fill_in "group[description]", with: "test test test"

    click_button "Create Group"

    expect(page).to have_text("Image can't be blank")
  end
end
