class IconsController < ApplicationController
    def index
      client = NounProjectApi::V1::Client.new
      @icons = client.icons(query: "plant", limit: 10)
    end
  
    def show
      client = NounProjectApi::V1::Client.new
      @icon = client.icon(params[:id])
    rescue NounProjectApi::V1::Client::IconNotFound
      render plain: "Icon not available"
    end
  end
  