require 'rails_helper'

feature 'Nabvar links', type: :feature, js: true do
  context 'when the user is not signed in' do
    it 'should not show the subscribe link after the user is subscribed' do
      visit root_path

      expect(page).to have_content('Sign in')
      expect(page).to have_content('Sign up')
    end
  end

  context 'when the user is signed in' do
    let :user do
      FactoryGirl.create :user, password: 'fakepass', password_confirmation: 'fakepass'
    end

    before do
      signin user.email, 'fakepass'
    end

    it 'should not show the subscribe alert' do
      visit root_path

      expect(page).to_not have_content('Sign in')
      expect(page).to_not have_content('Sign up')
    end
  end
end
