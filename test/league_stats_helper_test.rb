require './test/test_helper'


class LeagueStatsHelperTest < Minitest::Test

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

  def test_home_games_played
    expected = {"6"=>5, "3"=>2, "5"=>2, "16"=>4, "17"=>3, "8"=>2, "9"=>1}
    assert_equal expected, @tracker.home_games_played
  end

  def test_away_games_played
    expected = {"3"=>3, "6"=>4, "5"=>2, "17"=>4, "16"=>3, "9"=>2, "8"=>1}
    assert_equal expected, @tracker.away_games_played
  end

  def test_total_games_played
    expected = {"3"=>5, "6"=>9, "5"=>4, "17"=>7, "16"=>7, "9"=>3, "8"=>3}
    assert_equal expected, @tracker.total_games_played
  end

  def test_home_team_goals
    expected = {"6"=>14, "3"=>5, "5"=>1, "16"=>11, "17"=>8, "8"=>5, "9"=>6}
    assert_equal expected, @tracker.home_team_goals
  end

  def test_away_team_goals
    expected = {"3"=>5, "6"=>14, "5"=>1, "17"=>7, "16"=>5, "9"=>5, "8"=>1}
    assert_equal expected, @tracker.away_team_goals
  end

  def test_total_goals_by_game_team
    expected = {"3"=>10.0, "6"=>28.0, "5"=>2.0, "17"=>1.0}
    assert_equal expected, @tracker.total_goals_by_game_team
  end

  def test_total_games_by_game_team
    expected = {"3"=>5, "6"=>9, "5"=>4, "17"=>1}
    assert_equal expected, @tracker.total_games_by_game_team
  end

  def test_average_offense
    expected = {"3"=>2.0, "6"=>3.11, "5"=>0.5, "17"=>1.0}
    assert_equal expected, @tracker.average_offense
  end

  def test_home_team_goals_against
    expected = {"6"=>6, "3"=>5, "5"=>9, "16"=>7, "17"=>5, "8"=>5, "9"=>1}
    assert_equal expected, @tracker.home_team_goals_against
  end

  def test_away_team_goals_against
    expected = {"3"=>11, "6"=>6, "5"=>3, "17"=>11, "16"=>8, "9"=>5, "8"=>6}
    assert_equal expected, @tracker.away_team_goals_against
  end

  def test_total_goals_against
    expected = {"3"=>16, "6"=>12, "5"=>12, "17"=>16, "16"=>15, "9"=>6, "8"=>11}
    assert_equal expected, @tracker.total_goals_against
  end

  def test_games_won_game_team
    expected = {"6"=>8, "3"=>1}
    assert_equal expected, @tracker.games_won_game_team
  end

  def test_total_home_wins_by_team
    expected = {"6"=>5, "3"=>2, "5"=>2}
    assert_equal expected, @tracker.total_home_wins_by_team
  end
end
