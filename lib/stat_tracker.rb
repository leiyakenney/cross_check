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

<<<<<<< HEAD
  def self.from_csv(files)
    # games = files[:games]
    CSV.foreach(files[:games],:headers => true) do |row|

      binding.pry
    end
  end

=======
  def from_csv(file_names)
    game_gen(file_names)
  end

  def game_gen(file_names)
    game_gen = CSV.foreach(file_names[:games],:headers => true) do |row|
      @games.push(Game.new(row))

      binding.pry
    end
  end



>>>>>>> 35573327156542103a368c8e39c385ad446f32b4
  # def highest_total_score
  #   @games.max_by do |game|
  #     (game.winning_score + game.losing_score)
  #   end
  # end
end
