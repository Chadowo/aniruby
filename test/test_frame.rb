
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

  # We provided 300ms as duration for two frames
  def test_custom_duration
    @sample_animation.frames[0..1].each do |f|
      assert_equal 0.3, f.duration
    end
  end

  def test_default_duration
    # For the rest of the frames...
    @sample_animation.frames[2..3].each do |f|
      assert_equal 0.1, f.duration
    end
  end

  def test_dimensions
    @sample_animation.frames[2..3].each do |f|
      assert_equal @sprite_w, f.width
      assert_equal @sprite_h, f.height

      # Test the aliases too
      assert_equal @sprite_w, f.w
      assert_equal @sprite_h, f.h
    end
  end
end
