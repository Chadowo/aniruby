# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## 0.1.3 - 2023-08-22

### Fixed

- Undefined method error in animation, when using `size` on `AniRuby::Frames`, now
  use `Enumerable#count` instead.

### Changed

- The way milliseconds are used as duration, before you'll have to use whole numbers
  (1000 is a second, 500 half a second and so on), now we can just use floats for that (1.0 as a second, 0.5 half a second and so on).

## 0.1.2 - 2023-08-20

### Changed

- Downcased the gem name in the gemspec

## 0.1.1 - 2023-08-20

### Added

- Add .yardopts to included files

### Fixed

- Required ruby not being used correctly in gemspec

## 0.1.0 - 2023-08-20

Initial release
