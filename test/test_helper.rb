require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team'
require './lib/stat_tracker'
require './lib/game'
