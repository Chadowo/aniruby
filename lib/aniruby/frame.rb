
module AniRuby
  # A frame has a sprite that's Gosu::Image and a duration specified in
  # milliseconds
  class Frame
    attr_accessor :duration, :sprite
    attr_reader :w, :h

    # Create a new frame
    #
    # @param sprite [Gosu::Image]
    # @param duration [Float]
    #
    # @return [Frame]
    def initialize(sprite, duration = 0.1)
      @sprite = sprite
      @duration = duration

      @w = @sprite.width
      @h = @sprite.height
    end
  end
end
