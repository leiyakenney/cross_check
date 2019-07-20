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
end
