class Link < ApplicationRecord

  validates :original_url,
            presence: true,
            on: :create

  validates :custom_url,
            uniqueness: true,
            if: 'custom_url.present?'

  validate :custom_method

  validates_format_of :original_url,
                      with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/

  before_create :generate_short_url

  def custom_method
    if self.custom_url.present?
      find = Link.where(short_url: self.custom_url)
      errors.add(:custom_url, 'Impossible create the duplicate url') if find.present?
    end
  end
  def generate_short_url
    if custom_url.present?
      self.short_url = custom_url
    else
      chars = ['0'..'9','A'..'Z','a'..'z'].map{|range| range.to_a}.flatten
      self.short_url = 6.times.map{chars.sample}.join
      self.short_url = 6.times.map{chars.sample}.join until Link.find_by_short_url(self.short_url).nil?
    end
  end

  def find_duplicate
    Link.find_by_sanitized_url(self.sanitized_url)
  end

  def new_link?
    find_duplicate.nil?
  end

  def sanitize
    self.original_url.strip!
    self.sanitized_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    self.sanitized_url.slice!(-1) if self.sanitized_url[-1] == "/"
    self.sanitized_url = "http://#{self.sanitized_url}"
  end

end
