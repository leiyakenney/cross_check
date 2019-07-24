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

  def test_best_season
    assert_equal "20122013", @tracker.best_season("6")
  end

  def test_worst_season
    assert_equal "20132014", @tracker.worst_season("6")
  end

  def test_average_win_percentage
    assert_equal 0.89, @tracker.average_win_percentage("6")
  end

  def test_most_goals_scored
    assert_equal 6, @tracker.most_goals_scored("6")
  end

  def test_fewest_goals_scored
    assert_equal 0, @tracker.fewest_goals_scored("5")
  end

  def test_favorite_opponent
    assert_equal 'Penguins', @tracker.favorite_opponent("6")
  end

  def test_rival
    assert_equal 'Rangers', @tracker.rival("6")
  end

  def test_biggest_team_blowout
    assert_equal 1, @tracker.biggest_team_blowout("3")
  end

  def test_worst_loss
    assert_equal 3, @tracker.worst_loss("3")
  end

  def test_head_to_head
    expected = {"Rangers"=>0.8, "Penguins"=>1.0}
    assert_equal expected, @tracker.head_to_head("6")
  end

  def test_seasonal_summary
    expected = {
      "20122013" =>
      {:postseason=>
        {:win_percentage=>0.33,
          :total_goals_scored=>6,
          :total_goals_against=>11,
          :average_goals_scored=>2.0,
          :average_goals_against=>3.67}
        }
      }
    assert_equal expected, @tracker.seasonal_summary("8")
  end


end
