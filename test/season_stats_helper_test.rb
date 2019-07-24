require './test/test_helper'

class SeasonStatTsHelperTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/dummy_data_game_ts.csv'
    team_path = './data/dummy_data/dummy_data_teams.csv'
    game_teams_path = './data/dummy_data/dummy_data_game_team.csv'
    @file_names = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @tracker = StatTracker.from_csv(@file_names)
  end

  def test_games_played_regular_season
    expected = {"6"=>2, "3"=>1, "5"=>1, "17"=>2, "16"=>2, "8"=>2, "9"=>2}
    assert_equal expected, @tracker.games_played_regular_season("20122013")
  end

  def test_games_won_regular_season
    expected = {"6"=>2, "17"=>1, "16"=>1, "8"=>1, "9"=>1}
    assert_equal expected, @tracker.games_won_regular_season("20122013")
  end

  def test_games_lost_regular_season
    expected = {"6"=>2, "3"=>1, "5"=>1, "17"=>2, "16"=>2, "8"=>2, "9"=>2}
    assert_equal expected, @tracker.games_played_regular_season("20122013")
  end

  def test_win_percentage_regular_season
    expected = {"6"=>1.0, "3"=>0, "5"=>0, "17"=>0.5, "16"=>0.5, "8"=>0.5, "9"=>0.5}
    assert_equal expected, @tracker.win_percentage_regular_season("20122013")
  end

  def test_games_played_post_season
    expected = {"6"=>2, "3"=>1, "5"=>1, "16"=>5, "17"=>5, "8"=>1, "9"=>1}
    assert_equal expected, @tracker.games_played_post_season("20122013")
  end

  def test_games_won_post_season
    expected = {"6"=>2, "16"=>3, "17"=>2, "9"=>1}
    assert_equal expected, @tracker.games_won_post_season("20122013")
  end

  def test_win_percentage_post_season
    expected = {"6"=>1.0, "3"=>0, "5"=>0, "16"=>0.6, "17"=>0.4, "8"=>0, "9"=>1.0}
    assert_equal expected, @tracker.win_percentage_post_season("20122013")
  end

  def test_biggest_bust
    assert_equal "Canadiens", @tracker.biggest_bust("20122013")
  end

  def test_biggest_surprise
    assert_equal "Senators", @tracker.biggest_surprise("20122013")
  end

  def test_ppg_goals
    expected = {"3"=>0, "6"=>1, "5"=>0, "17"=>0}
    assert_equal expected, @tracker.ppg_goals("20122013")
  end
end
