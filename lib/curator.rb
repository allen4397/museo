require_relative 'photograph'

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
end
