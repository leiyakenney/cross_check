require './test/test_helper'

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
    @tracker = StatTracker.from_csv(@file_names)
  end

  def test_it_exists
    assert_instance_of StatTracker, @tracker
    assert_instance_of Game, @tracker.games[0]
    assert_instance_of GameTeams, @tracker.game_teams[0]
    assert_instance_of Team, @tracker.teams[0]
  end

  def test_initialization
    assert_equal "2012030221", @tracker.games[0].game_id
    assert_equal "2012030123", @tracker.games[18].game_id
    assert_equal "1", @tracker.teams[0].team_id
    assert_equal "27", @tracker.teams[18].team_id
    assert_equal 2, @tracker.game_teams[0].goals
    assert_equal 1, @tracker.game_teams[18].goals
  end
end
