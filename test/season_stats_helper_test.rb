require './test/test_helper'

class SeasonStatHelperTest < Minitest::Test

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

  def test_games_played_regular_season
    expected = {"6"=>1, "5"=>1, "17"=>1, "16"=>1}
    assert_equal expected, @tracker.games_played_regular_season("20122013")
  end

  def test_games_won_regular_season
    expected = {"6"=>1, "17"=>1}
    assert_equal expected, @tracker.games_won_regular_season("20122013")
  end

  def test_games_lost_regular_season
    expected = {"6"=>1, "5"=>1, "17"=>1, "16"=>1}
    assert_equal expected, @tracker.games_played_regular_season("20122013")
  end

  def test_win_percentage_regular_season
    expected = {"6"=>1.0, "17"=>1.0}
    assert_equal expected, @tracker.win_percentage_regular_season("20122013")
  end

  def test_games_played_post_season
    expected = {"6"=>3, "3"=>2, "5"=>1, "16"=>6, "17"=>6, "8"=>3, "9"=>3}
    assert_equal expected, @tracker.games_played_post_season("20122013")
  end

  def test_games_won_post_season
    expected = {"6"=>3, "16"=>4, "17"=>2, "9"=>2, "8"=>1}
    assert_equal expected, @tracker.games_won_post_season("20122013")
  end

  def test_win_percentage_post_season
    expected = {"6"=>1.0, "16"=>0.67, "17"=>0.33, "9"=>0.67, "8"=>0.33}
    assert_equal expected, @tracker.win_percentage_post_season("20122013")
  end
end
