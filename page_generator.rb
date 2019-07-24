require 'erb'
require './lib/game'
require './lib/game_teams'
require './lib/teams'
require './lib/stat_tracker'

template = File.read('./site/index.html.erb')

game_path = './data/game.csv'
team_path = './data/team_info.csv'
game_teams_path = './data/game_teams_stats.csv'

file_names = {
games: game_path,
teams: team_path,
game_teams: game_teams_path
}
@stat_tracker = StatTracker.from_csv(file_names)
File.write('./site/index.html', ERB.new(template).result(binding))
