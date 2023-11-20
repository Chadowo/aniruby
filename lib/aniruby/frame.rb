module AniRuby
  # A frame has a sprite that's Gosu::Image and a duration specified in
  # milliseconds
  class Frame
    # @return [Float]
    attr_accessor :duration

    # @return [Gosu::Image]
    attr_accessor :sprite

    # @return [Integer]
    attr_reader :width, :height

    alias :w :width
    alias :h :height

    # Create a new frame
    #
    # @param sprite [Gosu::Image]
    # @param duration [Float]
    #
    # @return [Frame]
    def initialize(sprite, duration = 0.1)
      @sprite = sprite
      @duration = duration

      @width = @sprite.width
      @height = @sprite.height
    end
  end
end
