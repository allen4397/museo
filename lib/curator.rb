require_relative 'photograph'
require_relative 'artist'

class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photograph_info)
    @photographs << Photograph.new(photograph_info)
  end

  def add_artist(artist_info)
    @artists << Artist.new(artist_info)
  end
end
