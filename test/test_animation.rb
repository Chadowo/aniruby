require 'minitest/autorun'
require_relative 'test_helper'

class AnimationTest < Minitest::Test
  include TestHelper

  def setup
    @sprite_w = 16
    @sprite_h = 23
    @duration = 0.2

    # This animation has 4 frames
    @sample_animation = AniRuby::Animation.new(media_dir('king_walk.png'),
                                               @sprite_w, @sprite_h,
                                               @duration)
  end

  def test_extra_durations_are_discarded
    # The king's walk animation has only four frames, but here
    # we passed six durations
    AniRuby::Animation.new(media_dir('king_walk.png'),
                           @sprite_w, @sprite_h,
                           0.1, 0.2, 0.3, 0.4, 0.5, 0.6)
  end

  def test_starts_at_one
    assert_equal 1, @sample_animation.cursor
  end

  def test_can_set_frame
    @sample_animation.cursor = 2

    assert_equal 2, @sample_animation.cursor
  end

  def test_is_done
    @sample_animation.cursor = @sample_animation.frames.count

    assert_equal true, @sample_animation.done?
  end

  # The width of the current frame
  def test_sprite_width
    assert_equal @sprite_w, @sample_animation.width
  end

  # The height of the current frame
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
    # Set the cursor to something else than zero
    @sample_animation.cursor = 2
    assert_equal 2, @sample_animation.cursor

    @sample_animation.reset
    assert_equal 0, @sample_animation.cursor
  end
end
