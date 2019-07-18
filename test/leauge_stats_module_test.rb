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
end
