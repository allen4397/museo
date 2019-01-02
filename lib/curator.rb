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

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photograph|
      photograph.id == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end

  def find_artists_with_multiple_photographs
    artists = []
    @photographs.each do |photograph|
      @photographs.each do |photo|
        if photo.artist_id == photograph.artist_id && photo != photograph
          artists << find_artist_by_id(photo.artist_id)
        end
      end
    end
    return artists.uniq
  end
end
