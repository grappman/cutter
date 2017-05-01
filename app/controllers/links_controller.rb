class LinksController < InheritedResources::Base

  before_action :find_url, only: [:show, :compressed]

  respond_to :js, :html

  def index
    @link = Link.new
  end

  def show
    redirect_to @link.sanitized_url
  end

  def create

    if link_params[:custom_url].present?
      @link = Link.new(link_params{original_url})
      @link.save
    else
      @link = Link.find_or_create_by(link_params)
    end
    respond_with(@link) do |success, failure|
      success.js {render layout: false}
    end
  end

  private

    def find_url
      @link       = Link.find_by(short_url:     params[:short_url])
    end

    def link_params
      params.require(:link).permit(:original_url, :custom_url)
    end

end