require 'spec_helper'

describe 'UserDatatable', js: true do

  it 'should render datatable' do
    create_list(:user, 15)
    visit users_path
    sleep 1
    screenshot_and_open_image
    expect(page).to have_content('Users Datatable')
  end

end
