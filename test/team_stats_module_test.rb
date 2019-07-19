require './test/test_helper'

class TeamStatsTest < Minitest::Test

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

  def test_biggest_team_blowout
    assert_equal 1, @tracker.biggest_team_blowout("3")
  end

  def test_worst_loss
    assert_equal 3, @tracker.worst_loss("3")
  end
end
