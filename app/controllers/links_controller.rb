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
    redirect_to shortened_path(@link.short_url) if @link.save
  end

  private

    def find_url
      @link = Link.find_by(short_url: params[:short_url])
    end

    def link_params
      params.require(:link).permit(:original_url, :custom_url)
    end

end