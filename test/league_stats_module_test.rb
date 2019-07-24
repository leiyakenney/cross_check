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

  def test_home_away_team_goals
    expected = {
      :hg=>{
        "6"=>14,
        "3"=>5,
        "5"=>1,
        "16"=>11,
        "17"=>8,
        "8"=>5,
        "9"=>6},
      :ag=>{
        "3"=>5,
        "6"=>14,
        "5"=>1,
        "17"=>7,
        "16"=>5,
        "9"=>5,
        "8"=>1
      }
    }
    assert_equal expected, @tracker.home_away_team_goals
  end

  def test_home_away_games_played
    expected_hg = {"6"=>5, "3"=>2, "5"=>2, "16"=>4, "17"=>3, "8"=>2, "9"=>1}
    assert_equal expected_hg, @tracker.home_away_games_played[:hg]
    expected_ag = {"3"=>3, "6"=>4, "5"=>2, "17"=>4, "16"=>3, "9"=>2, "8"=>1}
    assert_equal expected_ag, @tracker.home_away_games_played[:ag]
  end

  def test_high_low_scoring_home_team
    assert_equal [["5", 1], ["9", 6]], @tracker.high_low_scoring_home_team
  end

  def test_highest_scoring_home_team
    assert_equal 'Senators', @tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal 'Penguins', @tracker.lowest_scoring_home_team
  end

  def test_high_low_scoring_visitor
    assert_equal [["5", 1], ["6", 14]], @tracker.high_low_scoring_visitor
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

  def test_total_goals_games_gt
    expected_tgo = {"3"=>10.0, "6"=>28.0, "5"=>2.0, "17"=>1.0}
    assert_equal expected_tgo, @tracker.total_goals_games_gt[:tgo]
    expected_tga = {"3"=>5, "6"=>9, "5"=>4, "17"=>1}
    assert_equal expected_tga, @tracker.total_goals_games_gt[:tga]
  end

  def test_average_offense
    expected = {"3"=>2.0, "6"=>3.11, "5"=>0.5, "17"=>1.0}
    assert_equal expected, @tracker.average_offense
  end

  def test_best_worst_offense
    assert_equal [["5", 0.5], ["6", 3.11]], @tracker.best_worst_offense
  end

  def test_best_offense
    assert_equal "Bruins", @tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Penguins", @tracker.worst_offense
  end

  def test_best_defense
    assert_equal "Bruins", @tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Canadiens", @tracker.worst_defense
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

  def test_worst_fans
    assert_equal [], @tracker.worst_fans
  end
end
