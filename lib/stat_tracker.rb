require 'csv'
require 'pry'
class StatTracker

  def self.from_csv(files)
    data = {}
    files.each {|key, value|  data[key] = CSV.table(value)}
    data
  end

  game_path = './data/dummy_data_game.csv'
  team_path = './data/dummy_data_teams.csv'
  game_teams_path = './data/dummy_data_game_team.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }
  stat_data = StatTracker.from_csv(locations)
  binding.pry
end
