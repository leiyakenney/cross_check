require './test/test_helper'

class GameStatsTest < Minitest::Test

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

  def test_highest_total_score
    assert_equal 7, @tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 5, @tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.68, @tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.32, @tracker.percentage_visitor_wins
  end

  def test_count_of_games_by_season
    assert_equal ({"20122013" => 14, "20132014" => 3, "20142015" => 2}), @tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
      assert_equal 4.63, @tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal ({"20122013" => 4.57, "20132014" => 4.67, "20142015" => 5.00}), @tracker.average_goals_by_season
  end
end
