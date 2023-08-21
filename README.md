# AniRuby

[![Gem Version](https://badge.fury.io/rb/aniruby.svg)](https://badge.fury.io/rb/aniruby)

Make sprite animations on Gosu simple and easy.

## Summary

This library will provide you with a nice n easy interface to do sprite animations
on [Gosu](https://www.libgosu.org/), while being as nifty as possible

The library is made in pure Ruby with no dependencies at all (except Gosu, of course)

## Install

You can install the gem with the following command:

`gem install aniruby`

or use it with a bundle:

```ruby
# Somewhere in a Gemfile

gem 'aniruby'
```

## Getting Started

Using the less code possible:

```ruby

require 'gosu'
require 'aniruby'

class MyWindow < Gosu::Window
  def initialize
    super(800, 600, false)

    @animation = AniRuby::Animation.new('my_spritesheet.png', 32, 32,
                                        false, true,
                                        150)
  end

  def update
    @animation.update
  end

  def draw
    @animation.draw(0, 0)
  end
end
```

### Explanation

When you create a animation, you'll need to have an *spritesheet*, where you have
each sprite of the animation, that's the first argument to `Animation#new`, then
you'll need the dimensions of each individual sprite on your spritesheet, in the
example provided each sprite in the spritesheet is 32x32.

That is the bare minimum, you can specify filter type (retro in gosu's API), looping
and duration (for each individual frame too!).

provided you have the initilization right, you need to `update` your animation for it
to come to live!

NOTE: `Animation#draw` mimics the API of gosu' `Image#draw`, so you can give it
much more than single coordinates. there's `Animation#draw_rot` too!

## Roadmap

- more fine-grained control of animation
- being able to make an animation stitching `Gosu::Image`'s together
- mirroring

## License

[MIT](LICENSE)
