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

  def test_most_goals_scored
    assert_equal 6, @tracker.most_goals_scored(6)
  end

  def test_fewest_goals_scored
    assert_equal 0, @tracker.fewest_goals_scored(5)
  end

  def test_biggest_team_blowout
    assert_equal 1, @tracker.biggest_team_blowout("3")
  end

  def test_wins_by_season
    assert_equal ({"20122013"=>4, "20132014"=>2, "20142015"=>2}), @tracker.team_wins_by_season("6")
  end

  def test_num_games_by_season
    assert_equal ({"20122013"=>4, "20132014"=>3, "20142015"=>2}), @tracker.num_games_by_season("6")
  end

  def test_avg_win_percent_by_season
    assert_equal ({"20122013"=>1.0, "20132014"=>0.6666666666666666, "20142015"=>1.0}), @tracker.avg_win_percent_by_season("6")
  end

  def test_best_worst_season
    assert_equal [["20132014", 0.6666666666666666], ["20122013", 1.0]], @tracker.best_worst_season("6")
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

  def test_worst_loss
    assert_equal 3, @tracker.worst_loss("3")
  end

  def test_rival
    assert_equal 'Rangers', @tracker.rival("6")
  end

  def test_head_to_head
    expected = {"Rangers"=>0.8, "Penguins"=>1.0}
    assert_equal expected, @tracker.head_to_head("6")
  end



#=========== SEASONAL SUMMARY START ===========

  #seasonal_summary
  #returns a hash with seasons as key and game objects as value in array
  def test_collect_games_by_season
    skip
    assert_equal 100000, @tracker.collect_games_by_season("6")
  end

  #seasonal_summary
  #returns a hash with seasons as key, sub keys as post/pre season, and
  #game objects as values of post/pre season in a array
  def test_reg_vs_post
    skip
    assert_equal 100000, @tracker.reg_vs_post("6")
  end

  #seasonal_summary
  #helper method of reg_vs_post
  #returns postseason or preseason in replace of P or R
  def test_type_to_season
    skip
    assert_equal 100000, @tracker.type_to_season("P")
  end

  #seasonal_summary
  def test_seasonal_summary
    # skip
    expected = {"20122013" => {
        :regular_season => {
          :win_percentage => 0.68,
          :total_goals_scored => 100,
          :total_goals_against => 80,
          :average_goals_scored => 3,
          :average_goals_against => 2.2
        },
        :postseason => {
          :win_percentage => 0.55,
          :total_goals_scored => 20,
          :total_goals_against => 9,
          :average_goals_scored => 4,
          :average_goals_against => 3.1
        }
      }
    }
    assert_equal expected, @tracker.seasonal_summary("6")
  end
end
