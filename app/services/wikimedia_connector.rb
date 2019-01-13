require 'net/http'
require 'json'

class WikimediaConnector
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_urls
    response = Net::HTTP.get(uri)
    begin
      JSON.parse(response)["query"]["pages"].values.map { |page| page["imageinfo"].first["url"] }
    rescue
      raise Wikimedia::NoImageError.new
    end
  end

  def uri
    URI("https://commons.wikimedia.org/w/api.php?action=query&generator=images&prop=imageinfo&gimlimit=500&redirects=1&titles=#{name}&iiprop=url&format=json")
  end
end
