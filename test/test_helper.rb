require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

require 'minitest/autorun'
require 'minitest/pride'
require './lib/modules/game_stats_module'
require './lib/modules/league_stats_module'
require './lib/modules/league_stat_helper_module'
require './lib/modules/team_stats_module'
require './lib/modules/team_stat_helper_module'
require './lib/modules/global_helper_module'

require './lib/teams'
require './lib/game'
require './lib/game_teams'
require './lib/stat_tracker'
