require 'rails_helper'

RSpec.describe Member, type: :model do
  let!(:member_1) { Member.new(name: 'member1', website_url: 'http://example.com') }
  let!(:member_2) { Member.new(name: 'member2', website_url: 'http://example.com') }
  let!(:member_3) { Member.new(name: 'member3', website_url: 'http://example.com') }

  describe '#friendships' do

    context 'forward' do

      before do
        Friendship.create!(member_a: member_1, member_b: member_2)
        Friendship.create!(member_a: member_1, member_b: member_3)
      end

      it 'lists friendships' do
        expect(member_1.friendships.count).to eq(2)
      end
    end

    context 'backwards' do
      before do
        Friendship.create!(member_a: member_2, member_b: member_1)
        Friendship.create!(member_a: member_3, member_b: member_1)
      end

      it 'lists reverse friendships' do
        expect(member_1.friendships.count).to eq(2)
      end
    end

    context 'mixed' do
      before do
        Friendship.create!(member_a: member_1, member_b: member_2)
        Friendship.create!(member_a: member_3, member_b: member_1)
      end

      it 'lists reverse friendships' do
        expect(member_1.friendships.count).to eq(2)
      end
    end
  end

  describe '#friendships_count' do
    it 'increments the friendship count' do
      Friendship.create!(member_a: member_1, member_b: member_2)
      Friendship.create!(member_a: member_1, member_b: member_3)
      expect(member_1.reload.friendships_count).to eq(2)
      expect(member_2.reload.friendships_count).to eq(1)
      expect(member_3.reload.friendships_count).to eq(1)
    end

    it 'decrements the friendship count' do
      friendship = Friendship.create!(member_a: member_1, member_b: member_2)
      Friendship.create!(member_a: member_1, member_b: member_3)
      friendship.destroy
      expect(member_1.reload.friendships_count).to eq(1)
      expect(member_2.reload.friendships_count).to eq(0)
      expect(member_3.reload.friendships_count).to eq(1)
    end
  end
end
