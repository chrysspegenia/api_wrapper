class IconsController < ApplicationController

    def index
        client = NounProjectApi::V1::Client.new
        @icons = client.icons(
            q: "plant",
            limit_to_public_domain: 1,
            thumbnail_size: 84,
            include_svg: 1, 
            limit: 10
        )
    end

    def show
        client = NounProjectApi::V1::Client.new
        @icon = client.icon(params[:id])

        rescue NounProjectApi::V1::Client::IconNotFound
            render plain: "Icon not available"
    end

end
