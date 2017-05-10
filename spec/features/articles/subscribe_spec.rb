require 'rails_helper'

feature 'Subscribe', type: :feature, js: true do
  let :article do
    FactoryGirl.create :article, headline: 'Inspiring title'
  end

  context 'when the user is not signed in' do
    it 'should not show the subscribe link after the user is subscribed' do
      visit article_path(article)

      expect(page).to have_button('Subscribe')

      fill_in('Subscribe', with: 'jwolfe@wfsbs.com')

      click_button('Subscribe')

      expect(page).to have_content(article.headline)
      expect(page).to_not have_content('have not joined')

      visit article_path(article)
      expect(page).to_not have_content('have not joined')
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
      visit article_path(article)

      expect(page).to have_content(article.headline)
      expect(page).to_not have_content('have not joined')
    end
  end
end
