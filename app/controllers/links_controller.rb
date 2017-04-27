class LinksController < ApplicationController

  before_action :find_url, only: [:show, :compressed]

  def index
    @link = Link.new
  end

  def show
    redirect_to @link.sanitized_url
  end

  def create
    @link = Link.new(link_params)
    @link.sanitize

    url = @link.original_url.include?('//') ? @link.original_url : "http://#{@link.original_url}"

    # if @link.custom_url.present?
    #   find = Link.where(short_url: @link.custom_url)
    #
    #   if find.present?
    #     flash[:error] = 'Impossible create the duplicate url'
    #     redirect_to root_url
    #     return
    #   end
    # end

    unless @link.original_url.include?('.')
      flash[:error] = 'Incorrect url address'
      redirect_to root_url
      return
    end

    require 'faraday'
    res = Faraday.get(url)

    if res.status == 200 || res.status == 201 || res.status == 302
      if @link.new_link?
        if @link.save
          redirect_to shortened_path(@link.short_url)
        else
          flash[:error] = "Check the error below:"
          render 'index'
        end
      else
        flash[:notice] = "A short link for this URL is already in our database"
        redirect_to shortened_path(@link.find_duplicate.short_url)
      end
    else
      flash[:error] = "Bad http status: #{res.status}"
      redirect_to root_url
    end
  end

  private

  def find_url
    @link = Link.find_by_short_url(params[:short_url])
  end

  def link_params
    params.require(:link).permit(:original_url, :custom_url)
  end
end
