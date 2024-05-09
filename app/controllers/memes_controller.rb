class MemesController < ApplicationController
  
  def index
    client = Memegen::V1::Client.new
    @memes = client.meme_list
  end

  def generate_meme
      begin
        client = Memegen::V1::Client.new
        @meme= client.meme(meme: "10-Guy", top: "me", bottom: "after 500hrs of trial and error")
      rescue Memegen::V1::Client::MemeNotFound
        flash[:error] = "Meme not found. Please try again later."
      end
  end

end
  