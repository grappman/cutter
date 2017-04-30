class LinkSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id,
                   :original_url,
                   :short_url,
                   :http_status,
                   :result_url
  def result_url
    releted_link_url(object.short_url)
  end

end
