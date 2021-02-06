class ShortLinkService
  BITLY_URL = 'https://api-ssl.bitly.com/v4/bitlinks'

  def self.process(member)
    headers = {
      'Authorization' => "Bearer #{ENV['BITLY_ACCESS_TOKEN']}",
      'Content-Type' => 'application/json'
    }

    response = HTTP.headers(headers).post(BITLY_URL, json: { long_url: member.website_url })
    link = response.parse['link']

    if response.code == 200 || response.code == 201
      member.website_short_url = link
    else
      member.errors.add(:website_url, 'is not valid')
    end
  end
end
