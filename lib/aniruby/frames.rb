module AniRuby
  # Collection of frames
  class Frames
    include Enumerable

    # Create a new collection of frames
    #
    # @param sprites [Array<Gosu::Image>]
    def initialize(sprites)
      @frames = sprites.map do |sprite|
        AniRuby::Frame.new(sprite)
      end
    end

    # @param index [Integer]
    #
    # @return [Frame]
    def [](index)
      @frames[index]
    end

    def each(&block)
      @frames.each do |frame|
        if block_given?
          block.call(frame)
        else
          yield frame
        end
      end
    end
  end
end
