
module AniRuby
  class Frame
    attr_accessor :duration, :sprite, :width, :height

    def initialize(sprite, duration = 100)
      @sprite = sprite
      @duration = duration

      @w = @sprite.width
      @h = @sprite.height
    end
  end
end
