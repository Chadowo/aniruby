
require 'gosu'
require 'minitest/autorun'

require_relative 'test_helper'
require_relative '../lib/aniruby'

class AnimationTest < Minitest::Test
  include TestHelper

  def setup
    @sprite_w = 16
    @sprite_h = 23
    @duration = 0.2

    # The animation got 4 frames
    @sample_animation = AniRuby::Animation.new(media_dir('king_walk.png'),
                                               @sprite_w,
                                               @sprite_h,
                                               false,
                                               true,
                                               @duration)

  end

  def test_starts_at_zero
    assert_equal 0, @sample_animation.current_frame
  end

  # The width of the current frame
  def test_sprite_width
    assert_equal @sprite_w, @sample_animation.width
  end

# The width of the current frame
  def test_sprite_height
    assert_equal @sprite_h, @sample_animation.height
  end

  def test_loops
    assert_equal true, @sample_animation.loop
  end

  def test_duration
    @sample_animation.frames.each do |frame|
      assert_equal @duration, frame.duration
    end
  end

  def test_frames_count
    assert_equal 4, @sample_animation.frames.count
  end


  def test_can_be_paused
    @sample_animation.pause

    assert_equal true, @sample_animation.paused?
  end

  def test_can_be_unpaused
    @sample_animation.resume

    assert_equal false, @sample_animation.paused?
  end
end
