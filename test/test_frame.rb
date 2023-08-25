
require 'gosu'
require 'minitest/autorun'

require_relative 'test_helper'
require_relative '../lib/aniruby'

class FrameTest < Minitest::Test
  include TestHelper

  def setup
    @sprite_w = 16
    @sprite_h = 23

    # Note how we've only passed two durations to the animation
    @sample_animation = AniRuby::Animation.new(media_dir('king_walk.png'),
                                               @sprite_w,
                                               @sprite_h,
                                               false,
                                               true,
                                               0.3, 0.3)

  end

  # The sprite of a frame is a simple Gosu::Image
  def test_sprite
    @sample_animation.frames.each do |f|
      assert_instance_of Gosu::Image, f.sprite
    end
  end

   # We provide 300ms as duration for two frames
  def test_custom_duration
    @sample_animation.frames[0..1].each do |f|
      assert_equal 0.3, f.duration
    end
  end

  # The default is 100ms
  def test_default_duration
    @sample_animation.frames[2..3].each do |f|
      assert_equal 0.1, f.duration
    end
  end
end
