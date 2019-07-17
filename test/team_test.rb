require './test/test_helper'

class TeamTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/dummy_data_game.csv'
    team_path = './data/dummy_data/dummy_data_teams.csv'
    game_teams_path = './data/dummy_data/dummy_data_game_team.csv'
    @file_names = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @team = Team.new({:team_id => 2,})
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  # def test_team_info
  #
  # end

  def test_best_season

  end

end
