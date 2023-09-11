# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## 0.2.1 - 2023-09-07

### Fixed

- **Important**: in v0.2.0 one of the notable changes is that the instance variable `current_frame` was changed to `position`, following that there was
  the need to change every use of `@current_frame` to `@position`, however
  since I wasn't thorough enough I forgot to do that in the `Animation#draw` and `Animation#draw_rot`
  methods, effectively rendering them useless.
- **Important**: There was a error in `Animation#done?` too, where it'll return `false` always    
  independently of if the animation was finished, this was because I forgot to add a `return` in
  the condition check for the `true`.
- Internally, `Animation#update` now resets the animation, instead of `Animation#draw`  
or `Animation#draw_rot` (I know, that sounds counterintuitive). This (I think) fixes a precision problem when drawing the last frame
of an animation, in the which it was drawn for less time than required.

## 0.2.0 - 2023-09-02

This release brings mostly improvements and fixes, however there's not that much
new features yet.

### Added

- aliased `Animation#width` and `Animation#height` to `w` and `h` respectively, the same was done
for `Frame`.

### Changed

- `Animation#get_current_frame` is now `Animation#current_frame` as to not be redundant. Following that now `Animation#current_frame`(The accessor for the instance variable) is renamed to `Animation#position`.

### Fixed

- Previously methods like `Animation#pause?` or `Animation#resume` didn't return `self`, so it wasn't possible to chain them like this
  ```ruby
  # Example
  my_animation.pause.resume.duration(200)
  ```
  now they do so you can do that.

## 0.1.3 - 2023-08-22

### Fixed

- Undefined method error in animation, when using `size` on `AniRuby::Frames`, now
  use `Enumerable#count` instead.

### Changed

- The way milliseconds are used as duration, before you'll have to use whole numbers
  (1000 is a second, 500 half a second and so on), now we can just use floats for that (1.0 as a second, 0.5 half a second and so on).

## 0.1.2 - 2023-08-20

### Changed

- Downcased the gem name in the gemspec.

## 0.1.1 - 2023-08-20

### Added

- Add .yardopts to included files.

### Fixed

- Required ruby not being used correctly in gemspec.

## 0.1.0 - 2023-08-20

Initial release.
