class MemesController < ApplicationController
  
  def index
    @memes = client.meme_list
  end

  def generate_meme
      begin
        @meme= client.meme(meme: "10-Guy", top: "me", bottom: "after 500hrs of trial and error")
      rescue Memegen::V1::Client::MemeNotFound
        flash[:error] = "Meme not found. Please try again later."
      end
  end

  private

  def client
    Memegen::V1::Client.new
  end
end
  