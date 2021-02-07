class ExpertsController < ApplicationController
  def index
    @member = Member.find(params[:member_id])

    if (params[:search])
      @members = Member.joins(:headings).where('headings.value ILIKE ?', "%#{params[:search]}%").page(params[:page]).distinct
    else
      @members = []
    end
  end
end
