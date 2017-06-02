describe Vote do
  it 'should not be able to have multiple votes for the same voteable' do
    vote = FactoryGirl.create :vote
    expect(Vote.create(category: vote.category, user: vote.user, voteable: vote.voteable)).to_not be_persisted
  end
end
