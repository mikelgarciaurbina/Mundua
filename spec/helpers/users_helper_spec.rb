require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  it "name and lastname concat" do
    user = create(:user)
    expect(helper.full_name(user)).to eq("Mikel Garcia")
  end
end
