require 'rails_helper'

feature 'Show', type: :feature, js: true do
  let :article do
    FactoryGirl.create(:article)
  end

  context 'when the user is not signed in' do
    it 'should be able to read an article' do
      visit article_path(article)

      expect(page).to have_content('Whoa! It looks like you have not joined our online community, yet!')

      expect(page).to have_content(article.headline)
      expect(page).to have_content(article.body)
    end

    it 'should not be able to comment on the article' do
      visit article_path(article)

      expect(page).to have_content('Sign in or Sign up to Comment on this Article')
    end
  end

  context 'when the user is signed in' do
    let :user do
      FactoryGirl.create :user, password: 'fakepass', password_confirmation: 'fakepass'
    end

    let :comment_body do
      'Inspirational text'
    end

    before do
      signin user.email, 'fakepass'
    end

    it 'should be able to view the article' do
      visit article_path(article)

      expect(page).to have_content(article.headline)
      expect(page).to have_content(article.body)
    end

    it 'should be able to comment on the article' do
      visit article_path(article)

      click_on('Comment on this Article')

      expect {
        click_button 'Save Comment'
      }.to_not change(Comment, :count)

      fill_in 'comment_body', with: comment_body

      expect {
        click_button 'Save Comment'
      }.to change(Comment, :count).by(1)

      within "#comment-#{Comment.last.id}" do
        expect(page).to have_content(user.name)
        expect(page).to have_content("Member Since: #{user.created_at.strftime('%b %Y')}")
        expect(page).to have_content('from about less than a minute ago')
      end
    end

    context 'when there is a comment that the user created' do
      before do
        article.comments.create! user_id: user.id, body: comment_body
      end

      it 'should be able to be deleted' do
        visit article_path(article)

        expect(page).to have_content(comment_body)

        within "#comment-#{Comment.last.id}" do
          expect(page).to have_css('.fa-trash')

          find('.fa-trash').click
        end

        a = page.driver.browser.switch_to.alert
        a.accept

        sleep 1
        expect(page).to have_content(article.headline)
        expect(page).to have_content(article.body)
      end
    end

    context 'when there is a comment that some other user created' do
      let :other_user do
        FactoryGirl.create(:user)
      end

      before do
        article.comments.create! user_id: other_user.id, body: comment_body
      end

      it 'should not be able to be deleted' do
        visit article_path(article)

        expect(page).to have_content(comment_body)

        within "#comment-#{Comment.last.id}" do
          expect(page).to_not have_css('.fa-trash')
        end
      end

      context 'when the current user is an admin' do
        before do
          user.admin!
        end

        it 'should be able to be deleted' do
          visit article_path(article)

          expect(page).to have_content(comment_body)

          within "#comment-#{Comment.last.id}" do
            expect(page).to have_css('.fa-trash')

            find('.fa-trash').click
          end

          a = page.driver.browser.switch_to.alert
          a.accept

          sleep 1
          expect(page).to have_content(article.headline)
          expect(page).to have_content(article.body)
        end
      end
    end
  end
end
