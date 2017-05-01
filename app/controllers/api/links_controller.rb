class Api::LinksController < Api::ApplicationController

  def create
    if link_params[:custom_url].present?
      @link = Link.new(link_params{original_url})
      @link.save
    else
      @link = Link.find_or_create_by(link_params)
    end
    create! do |success, failure|
      success.json do
        render  json: @link, serializer: LinkSerializer
      end
    end
  end

  private

  def link_params
    params.require(:link).permit(:original_url, :custom_url)
  end

end