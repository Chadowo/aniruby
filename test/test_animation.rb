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

  def test_starts_at_zero
    assert_equal 0, @sample_animation.cursor
  end

  def test_can_set_cursor
    @sample_animation.cursor = 1

    assert_equal 1, @sample_animation.cursor
  end

  def test_is_done
    @sample_animation.cursor = @sample_animation.frames.count - 1

    assert_equal true, @sample_animation.done?
  end

  def test_sprite_width
    assert_equal @sprite_w, @sample_animation.width
  end

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
    @sample_animation.cursor = 1
    assert_equal 1, @sample_animation.cursor

    @sample_animation.reset
    assert_equal 0, @sample_animation.cursor
  end

  def test_duration_for_range_of_frames
    # The first two frames have a duration of 0.5 and the last two 0.9
    default_durations = {0..1 => 0.5, 2..3 => 0.9}

    anim = AniRuby::Animation.new(media_dir('king_walk.png'),
                                  @sprite_w, @sprite_h,
                                  default_durations)

    anim.frames[0..1].each { |f| assert_equal 0.5, f.duration }
    anim.frames[2..3].each { |f| assert_equal 0.9, f.duration }
  end

  def test_calls_to_i_on_frame_size_args
    mock_w = Minitest::Mock.new
    mock_w.expect :to_i, 16

    mock_h = Minitest::Mock.new
    mock_h.expect :to_i, 23

    AniRuby::Animation.new(media_dir('king_walk.png'),
                           mock_w, mock_h)

    assert_mock mock_w
    assert_mock mock_h
  end
end
