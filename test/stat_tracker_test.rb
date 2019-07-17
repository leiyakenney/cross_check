# require 'test_helper'
require './lib/stat_tracker'
require 'minitest/autorun'
require 'minitest/pride'
require './modules/game_stats'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/dummy_data_game.csv'
    team_path = './data/dummy_data/dummy_data_teams.csv'
    game_teams_path = './data/dummy_data/dummy_data_game_team.csv'
    @file_names = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @tracker = StatTracker.new(@file_names)
  end

  def test_instance
    assert_instance_of StatTracker, @tracker
  end

  def test_initialization
    assert_equal '2012030221', @tracker.games[0].data['game_id']
    assert_equal '2012030123', @tracker.games[18].data['game_id']
    assert_equal '1', @tracker.teams[0].data['team_id']
    assert_equal '27', @tracker.teams[18].data['team_id']
    assert_equal '2', @tracker.game_teams[0].data['goals']
    assert_equal '1', @tracker.game_teams[18].data['goals']
  end

  def test_module_works
    @tracker.highest_total_score
  end
end
