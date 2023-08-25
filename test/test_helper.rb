
require 'minitest/reporters'

module TestHelper
  # Get the abosule path to an asset under media/
  def media_dir(asset)
    File.join(File.expand_path('..', __FILE__), 'media', asset)
  end
end

Minitest::Reporters.use!
