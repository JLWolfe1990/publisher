require 'rails_helper'

feature 'Edit account', type: :feature, js: true do
  context 'when the user is signed in' do
    let :user do
      FactoryGirl.create :user, password: password, password_confirmation: password
    end

    let :password do
      'fakepass'
    end

    let :new_password do
      'fakepass1'
    end

    let :new_name do
      'Josh Wolfe'
    end

    before do
      signin user.email, 'fakepass'
    end

    it 'should be able to update the user\'s name' do
      find('.js-user-dropdown').click

      click_on 'Edit account'

      expect(page).to have_content('Edit User')

      fill_in 'user_name', with: new_name
      fill_in 'user_current_password', with: password

      click_on 'Update'

      find('.js-user-dropdown').click

      click_on 'Edit account'

      expect(page).to have_content('Edit User')

      expect(find_field('user_name').value).to eq(new_name)
    end
  end
end
