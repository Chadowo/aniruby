
require 'minitest/autorun'

require_relative 'test_helper'
require_relative '../lib/aniruby'

class FramesTest < Minitest::Test
  include TestHelper

  def setup
    @sprite_w = 16
    @sprite_h = 23

    @sample_animation = AniRuby::Animation.new(media_dir('king_walk.png'),
                                               @sprite_w,
                                               @sprite_h,
                                               false,
                                               true)
  end

  def test_each
    @sample_animation.frames.each do |frame|
      refute_nil frame
    end
  end

  def test_map
    mapped_frames = @sample_animation.frames.map do |frame|
      frame.duration = 0.5

      frame
    end

    mapped_frames.each do |frame|
      assert_equal 0.5, frame.duration
    end
  end

  def test_indexing
    assert_instance_of AniRuby::Frame, @sample_animation.frames[0]
  end
end
