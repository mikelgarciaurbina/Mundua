require 'rails_helper'

RSpec.feature "add_new_groups", type: :feature do
  it "add new group image blank" do
    user = create(:user)
    login_as user, scope: :user

    visit new_house_path
    login_as user, scope: :user

    page.execute_script("$('#house_latitude').val('121212')")
    page.execute_script("$('#house_longitude').val('121212')")
    fill_in "house[address]", with: "Calle Vargas, 3"
    fill_in "house[rooms]", with: "4"
    fill_in "house[description]", with: "test test test"

    click_button "Create House"

    expect(page).to have_text("Image can't be blank")
  end

  it "add new group latitude blank" do
    user = create(:user)
    login_as user, scope: :user

    visit new_house_path
    login_as user, scope: :user

    page.execute_script("$('#house_longitude').val('121212')")
    fill_in "house[address]", with: "Calle Vargas, 3"
    fill_in "house[rooms]", with: "4"
    fill_in "house[description]", with: "test test test"
    attach_file('Image', './spec/fixtures/test_img.png')

    click_button "Create House"

    expect(page).to have_text("Latitude can't be blank")
  end

  it "add new group longitude blank" do
    user = create(:user)
    login_as user, scope: :user

    visit new_house_path
    login_as user, scope: :user

    page.execute_script("$('#house_latitude').val('121212')")
    fill_in "house[address]", with: "Calle Vargas, 3"
    fill_in "house[rooms]", with: "4"
    fill_in "house[description]", with: "test test test"
    attach_file('Image', './spec/fixtures/test_img.png')

    click_button "Create House"

    expect(page).to have_text("Longitude can't be blank")
  end
end
