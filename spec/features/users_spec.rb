require 'spec_helper'

feature 'User management' do
  background do
    admin = create(:admin)
    sign_in admin
    visit root_path
  end

  scenario 'adds a new user' do

    expect {
      click_link 'Users'
      click_link 'New User'

      fill_in 'Email', with: 'taro@example.com'
      find('#password').fill_in 'Password', with: 'secret123'
      find('#password_confirmation').fill_in 'Password confirmation', with: 'secret123'
      click_button 'Create User'
    }.to change(User, :count).by(1)

    # save_and_open_page

    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'
    expect(page).to have_content 'Users'
    expect(page).to have_content 'taro@example.com'
  end
end
