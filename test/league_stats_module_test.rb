require './test/test_helper'

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
    assert_equal 'Devils', @tracker.convert_id_to_name(1)
  end

  def test_highest_scoring_home_team
    assert_equal 'Senators', @tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal 'Penguins', @tracker.lowest_scoring_home_team
  end

  def test_highest_scoring_away_team
    assert_equal 'Bruins', @tracker.highest_scoring_away_team
  end

  def test_lowest_scoring_home_team
    assert_equal 'Penguins', @tracker.lowest_scoring_away_team
  end

  def test_count_of_teams
    assert_equal 19, @tracker.count_of_teams
  end

  def test_best_defense
      #Needs work, no method
    skip
    assert_equal "Senators", @tracker.best_defense
  end

  def test_worst_defense
    #Needs work, no method
    skip
    assert_equal "Penguins", @tracker.worst_denfense
  end

  def test_best_offense

    assert_equal "Bruins", @tracker.best_offense
  end

  def test_worst_offense
    #need to double check correct value

    assert_equal "Penguins", @tracker.worst_offense
  end

  def test_best_fans
    skip
    #Name of the team with biggest difference between home and away win percentages.
    #1. Percentage of home wins 0.00
    #2. Percentage of away wins 0.00
    #3. Biggest difference - absolute value
    #4. Team 5 with difference of 3.5
  end
end
