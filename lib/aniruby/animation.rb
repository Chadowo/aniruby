
module AniRuby
  class Animation
    attr_accessor :frames, :current_frame, :loop

    def initialize(spritesheet, clip_w, clip_h, retro = false, loop = true, *durations)
      @frames = []
      @current_frame = 0

      @frame_w = clip_w
      @frame_h = clip_h

      @loop = loop
      @pause = false

      Gosu::Image.load_tiles(spritesheet,
                             @frame_w,
                             @frame_h,
                             retro: retro).each_with_index do |sprite, idx|
        @frames << AniRuby::Frame.new(sprite)
      end

      if durations.one?
        # Set every frame's delay to the only one provide
        @frames.each { |frame| frame.duration = durations[0]}
      else
        @frames.each_with_index do |frame, idx|
          # Set each frame to the duration provided, if there's no provide
          # duration for all frames then we'll leave it at the default
          frame.duration = durations[idx] unless durations[idx].nil?
        end
      end
    end

    def width
      @frames[@current_frame].sprite.width
    end

    def height
      @frames[@current_frame].sprite.height
    end

    def update
      return if done? || paused?

      @current_frame += 1 if frame_expired?
    end

    def draw(x, y, z = 0,
             scale_x = 1,
             scale_y = 1,
             color = Gosu::Color::WHITE,
             mode = :default)
      frame = @frames[@current_frame]

      frame.sprite.draw(x, y, z, scale_x, scale_y, color, mode)

      @current_frame = 0 if @loop && done?
    end

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

    def pause
      @pause = true
    end

    def resume
      @pause = false
    end

    def reset
      @current_frame = 0
    end

    def done?
      true if @current_frame == @frames.size - 1
    end

    def paused?
      return true if @pause

      false
    end

    # Returns the current frame object
    def get_current_frame
      @frames[@current_frame % @frames.size]
    end

    def frame_expired?
      now = Gosu.milliseconds
      @last_frame ||= now

      if (now - @last_frame) > @frames[@current_frame].duration
        @last_frame = now
      end
    end

    def duration(ms)
      @frames.each { |frame| frame.duration = ms}
    end
  end
end
