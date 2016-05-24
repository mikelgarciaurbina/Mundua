require 'rails_helper'

RSpec.feature "AddNewGroups", type: :feature do
  pending "add new group" do
    login_as create( :user ), scope: :user

    visit new_group_path

    within "#new_group" do
      fill_in "group[name]", with: "Ironhack"
      fill_in "group[description]", with: "test test test"
    end

    click_button "Create group"

    within "hover-tooltip" do
    end

    expect( Group.count ).to eq(1)
    expect( Group.first.name).to eq( "Ironhack")
  end
end
