require 'gosu'
require 'minitest/reporters'
require_relative '../lib/aniruby'

module TestHelper
  # Get the abosule path to an asset under media/
  def media_dir(asset)
    File.join(File.expand_path(__dir__), 'media', asset)
  end
end

Minitest::Reporters.use!
