class MembersController < ApplicationController
  def new
    @member = Member.new
  end

  def create
    @member = Member.new(permitted_params)

    ShortLinkService.process(@member) if @member.valid?

    if @member.errors.blank? && @member.save
      HeadingService.process(@member)
      redirect_to @member
    else
      render :new
    end
  end

  def show
    @member = Member.find(params[:id])
    @headings = @member.headings.page(params[:page]).per(5)
  end

  def index
    @members = Member.page(params[:page])
  end

  private

  def permitted_params
    params.require(:member).permit(:name, :website_url)
  end
end
