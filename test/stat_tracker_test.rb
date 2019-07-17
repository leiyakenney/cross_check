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

  # def test_module_works
  #   @tracker.highest_total_score
  # end
  #
  # def test_highest_total_score
  #   assert_equal "2012030222", @tracker.highest_total_score.data['game_id']
  # end
  #
  # def test_lowest_total_score
  #   assert_equal "2012030314", @tracker.lowest_total_score.data['game_id']
  # end
  #
  # def test_biggest_blowout
  #   assert_equal "2012030312", @tracker.biggest_blowout.data['game_id']
  # end
  #
  # def test_percentage_home_wins
  #   assert_equal 100.0, @tracker.percentage_home_wins('6')
  # end
  #
  # def test_percentage_visitor_wins
  #   assert_equal 75.0, @tracker.percentage_visitor_wins('6')
  # end
  #
  # def test_count_of_games_by_season
  #   assert_equal ({"20122013" => 19}), @tracker.count_of_games_by_season
  # end
  #
  # def test_average_goals_per_game
  #     assert_equal 4.63, @tracker.average_goals_per_game
  # end

  def test_average_goals_by_season
    assert_equal ({"20122013" => 4.57, "20132014" => 4.67, "20142015" => 5.00}), @tracker.average_goals_by_season
  end
end
