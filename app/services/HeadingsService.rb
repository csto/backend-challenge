require 'nokogiri'
require 'open-uri'

class HeadingsService
  def self.process(member)
    file = URI.open(member.website_short_url)
    doc = Nokogiri::HTML(file)

    doc.css('h1', 'h2', 'h3').map(&:text).each do |text|
      text_fragment = text[0..255]
      member.headings.create!(value: text_fragment) if text_fragment.present?
    end
  rescue Errno::ENOENT => e
    # No such file found
  end
end
