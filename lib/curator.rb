require_relative 'photograph'
require_relative 'artist'
require 'CSV'

class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def load_photographs(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      photo = Photograph.new(row)
      @photographs << photo
    end
  end

  def add_photograph(photograph_info)
    @photographs << Photograph.new(photograph_info)
  end

  def load_artists(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      artist = Artist.new(row)
      @artists << artist
    end
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

  def artists_from_country(country)
    @artists.find_all do |artist|
      artist.country == country
    end
  end

  def photographs_taken_by_artist_from(country)
    photos_by_artists_from_country = []
    artists_from_country(country).each do |artist|
      @photographs.find_all do |photograph|
        if artist.id == photograph.artist_id
          photos_by_artists_from_country << photograph
        end
      end
    end
    return photos_by_artists_from_country
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photograph|
      range.include?(photograph.year.to_i)
    end
  end

  def artists_photographs_by_age(artist)
    artists_photos_by_age = {}
    @photographs.each do |photograph|
      if photograph.artist_id == artist.id
        age = photograph.year.to_i - artist.born.to_i
        artists_photos_by_age[age] = photograph.name
      end
    end
    return artists_photos_by_age
  end
end
