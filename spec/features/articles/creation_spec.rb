require 'rails_helper'

feature 'Creation', type: :feature, js: true do
  context 'when the user is not signed in' do
    it 'should not see the create topic request link' do
      visit root_path

      expect(page).to_not have_css('.js-new-topic-request')
    end
  end

  context 'when the user is signed in' do
    let :user do
      FactoryGirl.create :user, password: 'fakepass', password_confirmation: 'fakepass'
    end

    before do
      signin user.email, 'fakepass'
    end

    it 'should be able to create a topic request' do
      visit root_path

      expect(page).to have_css('.js-new-topic-request')
      find('.js-new-topic-request').click

      fill_in('topic_request_title', with: 'TR1')
      fill_in('topic_request_description', with: 'TR1 Desc')

      click_on 'Create Topic request'

      expect(page).to have_current_path(topic_requests_path)
    end

    it 'should not be able to create an article' do
      visit root_path

      expect(page).to_not have_css('.js-new-article')
    end

    context 'and the user is a contributor' do
      let :user do
        FactoryGirl.create :user, :contributor, password: 'fakepass', password_confirmation: 'fakepass'
      end

      it 'should be able to create an article' do
        visit root_path

        expect(page).to have_css('.js-new-article')
      end
    end

    context 'and the user is an admin' do
      let :user do
        FactoryGirl.create :user, :admin, password: 'fakepass', password_confirmation: 'fakepass'
      end

      it 'should be able to create an article' do
        visit root_path

        expect(page).to have_css('.js-new-article')
      end
    end
  end
end
