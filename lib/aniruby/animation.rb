
module AniRuby
  # Has a AniRuby::Frames colletion, with a simple counter to keep track of
  # current frame plus looping and pausing functionality
  class Animation
    # @return [AniRuby::Frames] The collection of frames this animation uses
    attr_accessor :frames
    # @return [Integer] The current frame index of the animation
    attr_accessor :current_frame
    # @return [Boolean] The loop parameter
    attr_accessor :loop

    # Create a new animation
    #
    # @param spritesheet [String] Path to the spritesheet file
    # @param frame_w [Integer] The width of each individual frame
    # @param frame_h [Integer] The height of each individual frame
    # @param retro [Boolean] If true, the animation will not be interpolated when scaled
    # @param loop [Boolean] If true, the animation will loop indefinitely
    # @param durations [Float] The duration of the frames in MS (0.5 is half a second,
    #                              1.0 a second, etc). If there's more than one duration
    #                              provided they will be mapped to each frame of the
    #                              animation. The default for each frame is 0.1.
    #
    # @return [Animation] A new animation ready to play
    def initialize(spritesheet,
                   frame_w, frame_h,
                   retro = false,
                   loop = true,
                   *durations)
      @frame_w = frame_w
      @frame_h = frame_h

      @loop = loop

      @current_frame = 0
      @pause = false

      @frames = AniRuby::Frames.new(Gosu::Image.load_tiles(spritesheet,
                                                           @frame_w,
                                                           @frame_h,
                                                           retro: retro))

      # TODO: Maybe I could shorten this, adding an extra argument to
      #       AniRuby::Frames
      if durations.one?
        @frames.each { |frame| frame.duration = durations[0]}
      else
        @frames.each_with_index do |frame, idx|
          # Set each frame to the duration provided, if there's no provide
          # duration for all frames then we'll leave it at the default
          frame.duration = durations[idx] unless durations[idx].nil?
        end
      end
    end

    # Get the width of the current frame's image
    #
    # @return [Integer]
    def width
      @frames[@current_frame].width
    end

    alias :w :width

    # Get the height of the current frame's image
    #
    # @return [Integer]
    def height
      @frames[@current_frame].height
    end

    alias :h :height

    # Update the animation, advancing the frame counter. Note that this won't do
    # do anything if the animation is paused or has finished
    def update
      return if done? || paused?

      @current_frame += 1 if frame_expired?
    end

    # Draw the animation
    #
    # @param x [Integer] The X coordinate
    # @param y [Integer] The Y coordinate
    # @param z [Integer] The Z order
    # @param scale_x [Float] The horizontal scale factor
    # @param scale_y [Float] The vertical scale factor
    # @param color [Gosu::Color] The color to usw when drawing
    # @param mode [:default, :additive] The blending mode
    #
    # (see {draw_rot})
    def draw(x, y, z = 0,
             scale_x = 1,
             scale_y = 1,
             color = Gosu::Color::WHITE,
             mode = :default)
      frame = @frames[@current_frame]

      frame.sprite.draw(x, y, z, scale_x, scale_y, color, mode)

      @current_frame = 0 if @loop && done?
    end

    # Draw the animation rotated, with its rotational center at (x, y).
    #
    # @param x [Integer] The X coordinate
    # @param y [Integer] The Y coordinate
    # @param z [Integer] The Z order
    # @param angle [Float] The angle. in degrees
    # @param center_x [Float] the relative horizontal rotation origin
    # @param center_y [Float] the relative vertical rotation origin
    # @param scale_x [Float] The horizontal scale factor
    # @param scale_y [Float] The vertical scale factor
    # @param color [Gosu::Color] The color to usw when drawing
    # @param mode [:default, :additive] The blending mode
    #
    # (see {draw})
    def draw_rot(x, y, z = 0,
                 angle = 0,
                 center_x = 0.5,
                 center_y = 0.5,
                 scale_x = 1,
                 scale_y = 1,
                 color = Gosu::Color::WHITE,
                 mode = :default)
      frame = @frames[@current_frame]

      frame.sprite.draw_rot(x, y, z, angle, center_x, center_y, scale_x, scale_y, color, mode)

      # Loop the animation
      @current_frame = 0 if @loop && done?
    end

    # Pause the animation
    #
    # (see {resume})
    def pause
      @pause = true
    end

    # Resume the animation
    #
    # (see {pause})
    def resume
      @pause = false
    end

    # Set the animation to the beginning frame
    def reset
      @current_frame = 0
    end

    # Set the duration for all frames in the animation
    #
    # @param ms [Float] The new duration in milliseconds
    def duration(ms)
      @frames.each { |frame| frame.duration = ms}
    end

    # Is the animation finished?
    #
    # @return [Boolean]
    # @note This method will return true in intervals if the animation loops
    def done?
      true if @current_frame == @frames.count - 1
    end

    # Is the animation paused?
    #
    # @return [Boolean]
    def paused?
      return true if @pause

      false
    end

    # Get the current frame
    #
    # @return [AniRuby::Frame]
    def get_current_frame
      @frames[@current_frame % @frames.count]
    end

    # Has the current frame's duration expired?
    def frame_expired?
      now = Gosu.milliseconds / 1000.0
      @last_frame ||= now

      if (now - @last_frame) > @frames[@current_frame].duration
        @last_frame = now
      end
    end
  end
end
