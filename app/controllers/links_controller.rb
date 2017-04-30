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
    @link = Link.new(link_params)
    @link.sanitize

    create! do |format|
      format.js {render layout: false}
    end
  end

  private

    def find_url
      @exist_link = Link.find_by(original_url:  @link.original_url)
      @link       = Link.find_by(short_url:     params[:short_url])
    end

    def link_params
      params.require(:link).permit(:original_url, :custom_url)
    end

end