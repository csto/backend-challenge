class FriendshipsController < ApplicationController
  def new
    @member = Member.find(params[:member_id])

    if params[:search]
      @members = Member.where('name ILIKE ?', params[:search]).limit(50)
    else
      @members = []
    end
  end

  def create
    Friendship.create!(member_a_id: params[:member_id], member_b_id: params[:friend_id])
    redirect_to new_member_friendship_path(params[:member_id], search: params[:search])
  end

  def index
    @member = Member.find(params[:member_id])
  end
end
