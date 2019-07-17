require 'csv'
require 'pry'
require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './modules/game_stats'

class StatTracker
    include GameStats

attr_reader :games, :teams, :game_teams

  def initialize(file_names)
    @games = []
    @teams = []
    @game_teams = []
    # from_csv(file_names)
  end

  def self.from_csv(file_names)
    games = game_gen(file_names)
    team = team_gen(file_names)
    game_teams = game_teams_gen(file_names)
  end

  def self.game_gen(file_names)
    game_arr = []
    game_gen = CSV.foreach(file_names[:games],:headers => true) do |row|
      game_arr.push(Game.new(row))
    end
  end

  def self.team_gen(file_names)
    team_gen = CSV.foreach(file_names[:teams],:headers => true) do |row|
      @teams.push(Team.new(row))
    end
  end

  def self.game_teams_gen(file_names)
    game_teams_gen = CSV.foreach(file_names[:game_teams],:headers => true) do |row|
      @game_teams.push(GameTeams.new(row))
    end
  end

end
