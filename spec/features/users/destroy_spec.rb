require 'rails_helper'

feature 'Destroy account', type: :feature, js: true do
  context 'when the user is signed in' do
    let :user do
      FactoryGirl.create :user, password: 'fakepass', password_confirmation: 'fakepass'
    end

    let :password do
      'fakepass'
    end

    let :new_name do
      'Josh Wolfe'
    end

    before do
      signin user.email, password
    end

    it 'should be able to destroy his account' do
      visit edit_user_registration_path(user)

      expect(page).to have_content('Edit User')

      click_on 'Cancel my account'

      expect {
        page.driver.browser.switch_to.alert.accept
        sleep 1
      }.to change(User, :count).by(-1)

      expect(page).to have_content('Sign in')
    end
  end
end
