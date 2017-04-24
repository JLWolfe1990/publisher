require 'rails_helper'

feature 'Subscribe', type: :feature do
  let :article do
    FactoryGirl.create :article, headline: 'Inspiring title'
  end

  context 'when the user is not signed in' do
    it 'should not show the subscribe link after the user is subscribed' do
      visit article_path(article)

      expect(page).to have_button('Subscribe')
    end
  end
end
