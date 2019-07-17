require 'csv'
require 'pry'
require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './modules/game_stats'

class StatTracker
    include GameStats

attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    # from_csv(file_names)
  end

  def self.from_csv(file_names)
    games = game_gen(file_names)
    teams = teams_gen(file_names)
    game_teams = game_teams_gen(file_names)
    StatTracker.new(games, teams, game_teams)
  end

  def self.game_gen(file_names)
    game_arr = []
    CSV.foreach(file_names[:games],:headers => true) do |row|
      game_arr.push(Game.new(row))
    end
    game_arr
  end

  def self.teams_gen(file_names)
    teams_arr = []
    CSV.foreach(file_names[:teams],:headers => true) do |row|
      teams_arr.push(Team.new(row))
    end
    teams_arr
  end

  def self.game_teams_gen(file_names)
    game_teams_arr = []
    CSV.foreach(file_names[:game_teams],:headers => true) do |row|
      game_teams_arr.push(GameTeams.new(row))
    end
    game_teams_arr
  end

end
