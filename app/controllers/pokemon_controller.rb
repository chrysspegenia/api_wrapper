class PokemonController < ApplicationController
  
    #displays list of pokemon of region
    def pokedex
      region = params[:id] #params[:id] contains the region ID or name
      @pokemon_list = client.pokedex_entries(region)
      @region_data = client.region(region)
    end
    
    # Displays information about a specific Pokémon
    def show
      pokemon_name = params[:id] #params[:id] contains the Pokémon name or ID
      @pokemon = client.pokemon(pokemon_name)
    end

    #displays type data, moves, and pokemon of that type
    def typedex
      type_name = params[:id]
      @type = client.type(type_name)
    end

    private
  
    def client
      PokeApi::V1::Client.new
    end
  end
    