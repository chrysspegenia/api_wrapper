require 'faraday'
require 'oauth2'

class NounProjectApi::V1::Client
  class Error < RuntimeError; end
  class IconNotFound < Error; end

  BASE_URL = "https://api.thenounproject.com".freeze
  API_KEY = "706c8bc6b764457182a9743b9ec84c57"
  SECRET_KEY = "4a26a60fe1f946b0a50204ffcdc1bb18"

  def icons(**params)
    request(
      method: :get,
      endpoint: "v2/icon",
      params: params
    )
  end

  def icon(id)
    request(
      method: :get,
      endpoint: "v2/icon/#{id}"
    )
  end

  private

  def request(method:, endpoint:, params: {}, headers: {}, body: {})
    response = connection.public_send(method, endpoint) do |request|
      request.params = params
      request.headers = headers if headers.present?
      request.body = body.to_json if body.present?
    end

    return JSON.parse(response.body).with_indifferent_access if response.success?

    raise "Request Failed: #{response.status} - #{response.body}"
  end 

  def connection
    @connection ||= Faraday.new(url: BASE_URL) do |faraday|
      faraday.headers['Authorization'] = "Bearer #{access_token.token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def access_token
    @access_token ||= OAuth2::AccessToken.new(client, SECRET_KEY)
  end

  def client
    @client ||= OAuth2::Client.new(API_KEY, nil, site: BASE_URL)
  end
end
