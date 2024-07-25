# MIT License
#
# Copyright (c) 2024 Chadow
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

module AniRuby
  # Has a {Frames} collection, with a simple counter to keep track of
  # current frame plus looping and pausing functionality.
  # @example Loading and Playing an Animation
  #   require 'gosu'
  #   require 'aniruby'
  #
  #   class MyWindow << Gosu::Window
  #     def initialize
  #       super(1280, 720, resizable: true)
  #       @my_anim = AniRuby::Animation.new('path/to/spritesheet.png', 32, 32)
  #     end
  #
  #     def update
  #       # This line is very important, without it the animation will not play!
  #       @my_anim.update
  #     end
  #
  #     def draw
  #       # Draw approximately in the center of the screen
  #       @my_anim.draw(1280 / 2, 720 / 2, 0)
  #     end
  #   end
  class Animation
    # @return [AniRuby::Frames] The collection of frames this animation uses.
    attr_accessor :frames
    # @return [Integer] The index of the current frame.
    attr_accessor :cursor
    # @return [Boolean] The loop parameter.
    attr_accessor :loop

    # Create a new animation.
    #
    # @param spritesheet [String] Path to the spritesheet file.
    # @param frame_w [Integer, #to_i] The width of each individual frame.
    # @param frame_h [Integer, #to_i] The height of each individual frame.
    # @param durations [Float] The duration of the frames in MS (0.5 is half a second,
    #                              1.0 a second, etc). If there's more than one duration
    #                              provided they will be mapped to each frame of the
    #                              animation. The default for each frame is 0.1.
    #                              If the value is negative it'll default to 0.1.
    # @param retro [Boolean] If true, the animation will not be interpolated when scaled.
    # @param loop [Boolean] If true, the animation will loop indefinitely.
    #
    # @return [Animation] A new animation ready to play.
    def initialize(spritesheet,
                   frame_w, frame_h,
                   *durations,
                   retro: false,
                   loop: true)
      @frame_w = frame_w.to_i
      @frame_h = frame_h.to_i

      # Otherwise a floating point exception will ocurr
      if @frame_w.zero? || @frame_h.zero?
        raise ArgumentError, 'frame size must not be zero'
      end

      @loop = loop
      @pause = false

      @cursor = 0
      @step = 1

      @frames = AniRuby::Frames.new(Gosu::Image.load_tiles(spritesheet,
                                                           @frame_w,
                                                           @frame_h,
                                                           retro: retro))

      apply_durations(durations, @frames)
    end

    # If durations only contains one value, then it'll be applied
    # to all the frames, otherwise each duration will be applied
    # to the corresponding frame, until we run out of frames
    #
    # @api private
    #
    # @param durations [Array<Float>]
    # @param frames [AniRuby::Frames]
    # @return [void]
    def apply_durations(durations, frames)
      if durations.first.is_a?(Hash)
        durations.first.each do |k, v|
          frames[k].map! { |f| f.duration = v }
        end
      else
        # Default to 0.1 if the duration is negative
        # OPTIMIZE: In case durations are more than one, we'll be traversing
        #           through the whole array two times
        durations.map! { |dur| dur.negative? ? 0.1 : dur }

        if durations.one?
          frames.each { |frame| frame.duration = durations[0] }
        else
          durations.each_with_index do |duration, idx|
            break if frames[idx].nil?

            frames[idx].duration = duration
          end
        end
      end
    end

    # Get the width of the current frame's sprite.
    #
    # @return [Integer]
    def width
      @frames[@cursor].width
    end

    alias w width

    # Get the height of the current frame's sprite.
    #
    # @return [Integer]
    def height
      @frames[@cursor].height
    end

    alias h height

    # Update the animation, advancing the frame counter.
    #
    # @return [void]
    # @note Won't have any effect if the animation is paused.
    def update
      return unless frame_expired? && !paused?

      if !done?
        @cursor += @step
      elsif done? && @loop
        @cursor = 0
      end
    end

    # Has the current frame's duration expired?
    def frame_expired?
      now = Gosu.milliseconds / 1000.0
      @last_frame ||= now

      return false unless (now - @last_frame) > @frames[@cursor].duration

      @last_frame = now
      true
    end

    # @!group Drawing

    # Draw the animation.
    #
    # @param x [Integer] The X coordinate.
    # @param y [Integer] The Y coordinate.
    # @param z [Integer] The Z order.
    # @param scale_x [Float] The horizontal scale factor.
    # @param scale_y [Float] The vertical scale factor.
    # @param color [Gosu::Color] The color to usw when drawing.
    # @param mode [:default, :additive] The blending mode.
    #
    # @return [void]
    # @see draw_rot
    def draw(x, y, z = 0,
             scale_x = 1,
             scale_y = 1,
             color = Gosu::Color::WHITE,
             mode = :default)
      frame = @frames[@cursor]

      frame.sprite.draw(x, y, z, scale_x, scale_y, color, mode)
    end

    # Draw the animation rotated, with its rotational center at (x, y).
    #
    # @param x [Integer] The X coordinate.
    # @param y [Integer] The Y coordinate.
    # @param z [Integer] The Z order.
    # @param angle [Float] The angle, in degrees.
    # @param center_x [Float] the relative horizontal rotation origin.
    # @param center_y [Float] the relative vertical rotation origin.
    # @param scale_x [Float] The horizontal scale factor.
    # @param scale_y [Float] The vertical scale factor.
    # @param color [Gosu::Color] The color to usw when drawing.
    # @param mode [:default, :additive] The blending mode.
    #
    # @return [void]
    # @see draw
    def draw_rot(x, y, z = 0,
                 angle = 0,
                 center_x = 0.5,
                 center_y = 0.5,
                 scale_x = 1,
                 scale_y = 1,
                 color = Gosu::Color::WHITE,
                 mode = :default)
      frame = @frames[@cursor]

      frame.sprite.draw_rot(x, y, z, angle, center_x, center_y, scale_x, scale_y, color, mode)
    end

    # @!endgroup

    # @!group Utility

    # Pause the animation.
    #
    # @return [self]
    # @see resume
    def pause
      @pause = true

      self
    end

    # Resume the animation.
    #
    # @return [self]
    # @see pause
    def resume
      @pause = false

      self
    end

    # Reset the animation to its initial frame.
    #
    # @return [self]
    def reset
      @cursor = 0

      self
    end

    # Set the duration for all frames in the animation.
    #
    # @param ms [Float] The new duration in milliseconds.
    #
    # @return [self]
    def duration(ms)
      @frames.each { |frame| frame.duration = ms }

      self
    end

    # Is the animation finished?
    #
    # @return [Boolean]
    # @note This method will return true in intervals if the animation loops.
    def done?
      return true if @cursor == (@frames.count - 1)

      false
    end

    # Is the animation paused?
    #
    # @return [Boolean]
    def paused?
      return true if @pause

      false
    end

    # Get the current frame.
    #
    # @return [AniRuby::Frame]
    def current_frame
      @frames[@cursor % @frames.count]
    end

    # @!endgroup
  end
end
