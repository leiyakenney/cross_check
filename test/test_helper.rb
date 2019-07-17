require 'minitest/autorun'
require 'minitest/pride'
require 'simplecov'
require'./lib/team'
require'./lib/stat_tracker'
require'./lib/game'

SimpleCov.start do
  add_filter "/test/"
end
