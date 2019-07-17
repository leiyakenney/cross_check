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
  end

  def test_initialization
    assert_equal 2012030221, @tracker.games[0].game_id
    assert_equal 2012030123, @tracker.games[18].game_id
    assert_equal 1, @tracker.teams[0].team_id
    assert_equal 27, @tracker.teams[18].team_id
    # assert_equal '2', @tracker.game_teams[0].home_goals
    # assert_equal '1', @tracker.game_teams[18].goals
  end

  def test_module_works
    @tracker.highest_total_score
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

  def test_convert_id_to_name
    assert_equal 'Devils', @tracker.convert_id_to_name(1)
  end

  def test_highest_scoring_home_team
    assert_equal 'Senators', @tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal 'Penguins', @tracker.lowest_scoring_home_team
  end
end
