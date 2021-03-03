require 'rails_helper'

describe 'dashboard' do
  describe 'redirect path', :vcr do
    it 'redirects to edit page if user has not entered household_size' do
      user2 = User.create!(email: 'test8@gmail.com', total_points: 150,
                           full_name: 'Catherine Dean')
      user3 = User.create!(email: 'test28@gmail.com', total_points: 150,
                           full_name: 'Catherine Dean')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
      login_as user2
      usage_stub_3 = File.read('spec/fixtures/friends.json')
      stub_request(:get, /friendship/).to_return(
        status: 200, body: usage_stub_3
      )
      usage_stub_1 = File.read('spec/fixtures/usage_data.json')
      stub_request(:get, /usages/)
        .to_return(status: 200, body: usage_stub_1)

      usage_stub_2 = File.read('spec/fixtures/utilities.json')
      stub_request(:get, /providers/)
        .to_return(status: 200, body: usage_stub_2)

      visit dashboard_index_path

      expect(current_path).to eq(edit_user_path(user2))
    end
  end
end