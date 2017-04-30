class Api::LinksController < Api::ApplicationController

  def create
    @link = Link.new(link_params)
    @link.sanitize

    create! do |success, failure|
      success.json {
        render  json: @link, serializer: LinkSerializer
      }
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url, :custom_url)
  end

end