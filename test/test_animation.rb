
require 'minitest/autorun'

require_relative 'test_helper'
require_relative '../lib/aniruby'

class AnimationTest < Minitest::Test
  include TestHelper

  def setup
    @sprite_w = 16
    @sprite_h = 23
    @duration = 0.2

    # This animation has 4 frames
    @sample_animation = AniRuby::Animation.new(media_dir('king_walk.png'),
                                               @sprite_w,
                                               @sprite_h,
                                               false,
                                               true,
                                               @duration)

  end

  def test_starts_at_zero
    assert_equal 0, @sample_animation.position
  end

  def test_can_set_frame
    @sample_animation.position = 1

    assert_equal 1, @sample_animation.position
  end

  def test_is_done
    @sample_animation.position = @sample_animation.frames.count - 1

    assert_equal true, @sample_animation.done?
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

  def test_can_set_duration
    @sample_animation.duration(0.3)

    @sample_animation.frames.each do |frame|
      assert_equal 0.3, frame.duration
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

  def test_can_be_reset
    # Set the position to something else than zero
    @sample_animation.position = 2
    assert_equal 2, @sample_animation.position

    @sample_animation.reset
    assert_equal 0, @sample_animation.position
  end
end
