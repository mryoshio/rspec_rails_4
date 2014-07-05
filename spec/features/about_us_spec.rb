require 'spec_helper'

feature 'About BigCo modal' do
  scenario 'toggles display of the modal about display', js: true do
    visit root_path

    expect(page).not_to have_content 'About BigCo'
    expect(page).not_to have_content 'BigCo produces the finest widgets'

    click_link 'About Us'

    expect(page).to have_content 'About BigCo'
    expect(page).to have_content 'BigCo produces the finest widgets'

    within '#about_us' do
      click_button 'Close'
    end

    expect(page).not_to have_content 'About BigCo'
    expect(page).not_to have_content 'BigCo produces the finest widgets'
  end
end
