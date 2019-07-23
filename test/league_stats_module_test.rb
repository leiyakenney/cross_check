require './test/test_helper'
require 'mocha/minitest'

class LeagueStatsTest < Minitest::Test

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

  def test_convert_id_to_name
    assert_equal 'Devils', @tracker.convert_id_to_name("1")
  end

  def test_highest_scoring_home_team
    assert_equal 'Senators', @tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal 'Penguins', @tracker.lowest_scoring_home_team
  end

  def test_highest_scoring_visitor
    assert_equal 'Bruins', @tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal 'Penguins', @tracker.lowest_scoring_visitor
  end

  def test_count_of_teams
    assert_equal 19, @tracker.count_of_teams
  end

  def test_best_defense
    assert_equal "Bruins", @tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Canadiens", @tracker.worst_defense
  end

  def test_best_offense
    assert_equal "Bruins", @tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Penguins", @tracker.worst_offense
  end

  def test_winningest_team
    assert_equal "Bruins", @tracker.winningest_team
  end

  def test_total_games_played
    expected = {"3"=>5, "6"=>9, "5"=>4, "17"=>7, "16"=>7, "9"=>3, "8"=>3}
    assert_equal expected, @tracker.total_games_played
  end

  def test_best_fans
    assert_equal "Rangers", @tracker.best_fans
  end

  def test_total_home_wins
    expected = {"6"=>5, "3"=>2, "5"=>2}
    assert_equal expected, @tracker.total_home_wins_by_team
  end

  def test_total_away_wins
    expected = {"3"=>3, "6"=>4, "5"=>2, "17"=>1}
    assert_equal expected, @tracker.total_away_wins_by_team
  end

  def test_worst_fans
    assert_equal [], @tracker.worst_fans
  end
end
