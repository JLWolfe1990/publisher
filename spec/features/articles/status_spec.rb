require 'rails_helper'

feature 'Creation', type: :feature, js: true do
  context 'when the user is signed in' do
    let :user do
      FactoryGirl.create :user, password: 'fakepass', password_confirmation: 'fakepass'
    end

    before do
      signin user.email, 'fakepass'
    end

    context 'and the user is a contributor' do
      let :user do
        FactoryGirl.create :user, :contributor, password: 'fakepass', password_confirmation: 'fakepass'
      end

      it 'should be able to create a draft' do
        visit root_path

        expect(page).to have_css('.js-new-article')
        click_on('.js-new-article')
        fill_in('headline', with: 'headline')
        fill_in('description', with: 'description')
        fill_in('body', with: 'body')

        click_on('Save as Draft')

        click_on('Edit')

        click_on('Publish')

        expect(page).to have_content('headline')
        expect(page).to have_content('description')
      end
    end
  end
end
