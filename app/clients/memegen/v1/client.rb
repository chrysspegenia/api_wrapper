class Memegen::V1::Client
  class Error < RuntimeError; end
  class MemeNotFound < Error; end

  #url used only on the meme method
  MEME_URL = 'https://apimeme.com/meme'.freeze

  IMGFLIP_URL = "https://api.imgflip.com".freeze

  ERROR_CODES = {
    404 => MemeNotFound
  }.freeze

  def meme(params = {})
    build_url(
      params: params
    )
  end

  def meme_list(params ={})
    request(
      method: :get,
      endpoint: "get_memes",
      params: params
    )
  end

  private

  def build_url(params: {})
      url = URI.parse(MEME_URL)
      url.query = URI.encode_www_form(params)
      url
  end

    def request(method:, endpoint:, params: {}, headers: {}, body: {})
      response = connection.public_send(method, "#{endpoint}") do |request|
        request.params = {**params }
        request.headers = headers   if headers.present?
        request.body = body.to_json if body.present?
    end

    if response.success?
      data = JSON.parse(response.body)
      memes = data["data"]["memes"]
      return memes
    else
      raise ERROR_CODES[response.status]
    end
  end

  def connection
    @connection ||= Faraday.new(url: IMGFLIP_URL)
  end
end
  