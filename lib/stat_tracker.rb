require 'csv'
require 'pry'
require './lib/game'

class StatTracker

attr_reader :games, :teams

  def initialize(file_names)
    @games = []
    @teams = []
    from_csv(file_names)
  end

  def from_csv(file_names)
    game_gen(file_names)
  end

  def game_gen(file_names)
    game_gen = CSV.foreach(file_names[:games],:headers => true) do |row|
      @games.push(Game.new(row))
    end
  end



  # def highest_total_score
  #   @games.max_by do |game|
  #     (game.winning_score + game.losing_score)
  #   end
  # end
end
