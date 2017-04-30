class Link < ApplicationRecord

  validates         :original_url,
                    presence: { message: I18n.t('custom_errors.original_url.presence')},
                    on: :create

  validates         :original_url,
                    url: { message: I18n.t('custom_errors.original_url.url')}

  validates         :custom_url,
                    uniqueness: { message: 'A short link for this URL is already in our database' },
                    if: 'custom_url.present?',
                    on: :create

  validates         :sanitized_url,
                    uniqueness: { message: I18n.t('custom_errors.sanitized_url') }

  validate          :custom_url_exist?,
                    if: 'custom_url.present?'

  validate          :http_status_valid?

  before_create     :generate_short_url

  before_validation :get_http_status

  def http_status_valid?
    errors.add(:http_status, I18n.t('custom_errors.http_status_valid')) if http_status >= 400
  end

  def get_http_status
    url = Faraday.get(original_url)
    self.http_status = url.status
  end

  def custom_url_exist?
    errors.add(:custom_url, I18n.t('custom_errors.custom_url_exist')) if Link.where(short_url: custom_url).present?
  end

  def generate_short_url
    if custom_url.present?
      self.short_url = custom_url
    else
      chars = ['0'..'9','A'..'Z','a'..'z'].map{|range| range.to_a}.flatten
      self.short_url = 6.times.map{chars.sample}.join
      self.short_url = 6.times.map{chars.sample}.join until Link.find_by_short_url(short_url).nil?
    end
  end

  def sanitize
    self.original_url.strip!
    self.sanitized_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    self.sanitized_url.slice!(-1) if sanitized_url[-1] == "/"
    self.sanitized_url = "http://#{sanitized_url}"
  end

end