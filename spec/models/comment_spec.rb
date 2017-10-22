describe Comment do
  context 'validations' do
    it 'should not be valid without a user' do
      comment = Comment.new user_id: nil
      comment.save

      expect(comment.errors).to include(:user_id)
    end

    it 'should not be valid without a body' do
      comment = Comment.new body: nil
      comment.save

      expect(comment.errors).to include(:body)
    end
  end
end
