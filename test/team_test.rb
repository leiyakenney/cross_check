require 'minitest/autorun'
require 'minitest/pride'
# require 'test_helper'
require'./lib/team'
require'./lib/stat_tracker'
require'./lib/game'


class TeamTest < Minitest::Test

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
    @team = Team.new
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_highest_total_score
    assert_equal "2012030312", @tracker.highest_total_score.data['game_id']
  end

  def test_lowest_total_score
    assert_equal "2012030314", @tracker.lowest_total_score.data['game_id']
  end

  def test_biggest_blowout
    assert_equal "2012030312", @tracker.biggest_blowout.data['game_id']
  end

  def test_percentage_home_wins
    assert_equal 100.0, @tracker.test_percentage_home_wins(6)
  end

  def test_percentage_visitor_wins
    assert_equal 75.0, @tracker.test_percentage_visitor_wins(6)
  end

  def test_count_of_games_by_season
    assert_equal ({"20122013" => 19}), @tracker.test_count_of_games_by_season
  end

  def test_average_goals_per_game
      assert_equal 4.63, @tracker.test_average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal ({"20122013" => 4.63}), @tracker.test_average_goals_per_game
  end

end
