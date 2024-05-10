class PokeApi::V1::Client
    class Error < RuntimeError; end
    class PokemonNotFound < Error; end
  
    BASE_URL = 'https://pokeapi.co/api/v2'.freeze
    ERROR_CODES = {
      404 => PokemonNotFound
    }.freeze
    
    def pokemon(name)
        response = request(
          method: :get,
          endpoint: "pokemon/#{name}", #takes in pokemon id or name
        )
        { 'name' => response['name'],
          'id' => response['id'], 
          'types' => response['types'], 
          'sprites' => response['sprites']}
      end

    def pokedex_entries(region)
      response = request(
        method: :get,
        endpoint: "pokedex/#{region}", #takes in region id or name
      )
      response["pokemon_entries"]
    end

    def region(region)
      response = request(
        method: :get,
        endpoint: "pokedex/#{region}",
      )
      {'name' => response['name'], 'id' => response['id']}
    end

    def type(type)
      response = request(
        method: :get,
        endpoint: "type/#{type}",
      )
      {
        'id' => response['id'],
        'name' => response['name'],
        'moves' => response['moves'],
        'pokemon' => response['pokemon']
      }
    end

    private
  
    def request(method:, endpoint:, params: {}, headers: {}, body: {})
      response = connection.public_send(method, "#{endpoint}") do |request|
        request.params = { **params }
        request.headers = headers   if headers.present?
        request.body = body.to_json if body.present?
      end
  
      return JSON.parse(response.body).with_indifferent_access if response.success?
      raise ERROR_CODES[response.status]
    end
  
    def connection
      @connection ||= Faraday.new(url: BASE_URL)
    end
  end
  