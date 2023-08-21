
module AniRuby
  # A frame has a sprite and a duration in milliseconds
  class Frame
    attr_accessor :duration, :sprite
    attr_reader :w, :h

    def initialize(sprite, duration = 100)
      @sprite = sprite
      @duration = duration

      @w = @sprite.width
      @h = @sprite.height
    end
  end
end
