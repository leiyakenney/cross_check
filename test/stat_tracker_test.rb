# require 'test_helper'
require './lib/stat_tracker'
require 'minitest/autorun'
require 'minitest/pride'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/dummy_data_game.csv'
    team_path = './data/dummy_data/dummy_data_teams.csv'
    game_teams_path = './data/dummy_data/dummy_data_game_team.csv'
    file_names = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @tracker = StatTracker.new(file_names)
  end

  def test_instance
    assert_instance_of StatTracker, @tracker
  end

  def test_initialization
    assert @tracker.games
    assert @tracker.teams
  end

end
