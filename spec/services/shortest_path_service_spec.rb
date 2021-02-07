RSpec.describe ShortestPathService do
  describe '#process' do
    let!(:member_1) { Member.new(name: 'member1', website_url: 'http://example.com') }
    let!(:member_2) { Member.new(name: 'member2', website_url: 'http://example.com') }
    let!(:member_3) { Member.new(name: 'member3', website_url: 'http://example.com') }

    before do
      allow(ShortLinkService).to receive(:process).and_return(nil)
    end

    context 'with one friend away' do
      before do
        Friendship.create!(member_a: member_1, member_b: member_2)
      end

      it 'finds the shortest path' do
        path = ShortestPathService.process(member_1.id, member_2.id)
        expect(path).to eq([member_1.id, member_2.id])
      end
    end

    context 'with two friends away' do
      before do
        Friendship.create!(member_a: member_1, member_b: member_2)
        Friendship.create!(member_a: member_2, member_b: member_3)
      end

      it 'finds the shortest path' do
        path = ShortestPathService.process(member_1.id, member_3.id)
        expect(path).to eq([member_1.id, member_2.id, member_3.id])
      end
    end

    context 'without a connnection' do
      it 'fails to find a path' do
        path = ShortestPathService.process(member_1.id, member_3.id)
        expect(path).to be_falsey
      end
    end
  end
end
