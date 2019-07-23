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

  def test_ppg_goals
    expected = {"3"=>0, "6"=>1, "5"=>0, "17"=>0}
    assert_equal expected, @tracker.ppg_goals("20122013")
  end
end
