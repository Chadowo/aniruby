require 'minitest/autorun'

class TestVersion < Minitest::Test
  def test_version
    assert_equal "#{AniRuby::MAJOR}.#{AniRuby::MINOR}.#{AniRuby::PATCH}",
                 AniRuby::VERSION
  end
end
