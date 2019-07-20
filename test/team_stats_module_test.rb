require './test/test_helper'

class GameStatsTest < Minitest::Test

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

  def test_team_info
    expected = {"team_id" => "1", "franchise_id" => "23", "short_name" => "New Jersey", "team_name" => "Devils", "abbreviation" => "NJD", "link" => "/api/v1/teams/1" }
    assert_equal expected, @tracker.team_info("1")
  end

  def test_favorite_opponent
    assert_equal 'Penguins', @tracker.favorite_opponent("6")
  end
  
  def test_most_goals_scored
    assert_equal 6, @tracker.most_goals_scored(6)
  end

  def test_fewest_goals_scored
    assert_equal 0, @tracker.fewest_goals_scored(5)
  end
end
