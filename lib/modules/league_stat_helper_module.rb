module LeagueStatHelpers

  def home_away_games_played
    home_away = {:hg => Hash.new(0), :ag => Hash.new(0)}
    @games.each do |game|
      home_away[:hg][game.home_team_id] += 1
      home_away[:ag][game.away_team_id]+= 1
    end
    home_away
  end

  def total_games_played
    tg = {}
    home_away_games_played[:hg]
      .each {|id, gp| tg[id] = (gp + home_away_games_played[:ag][id])}
     tg
  end

  def home_away_team_goals
    goals_home_away = {:hg => Hash.new(0), :ag => Hash.new(0)}
    @games.each do |game|
      goals_home_away[:hg][game.home_team_id] += game.home_goals
      goals_home_away[:ag][game.away_team_id] += game.away_goals
    end
    goals_home_away
  end

  def total_goals_games_gt
    total_goal_game = {:tgo => Hash.new(0), :tga => Hash.new(0)}
    @game_teams.each do |game|
      total_goal_game[:tgo][game.team_id] += game.goals.to_f
      total_goal_game[:tga][game.team_id] += 1
    end
    total_goal_game
  end

  def average_offense
    avg_offense = Hash.new
    total_goals_games_gt[:tgo].each do |team_id, total_goals|
      avg_offense[team_id] =
      (total_goals_games_gt[:tgo][team_id]/total_goals_games_gt[:tga][team_id]).round(2)
    end
    avg_offense
  end

  def home_away_goals_against
    home_away_against = {:hga => Hash.new(0), :aga => Hash.new(0)}
    @games.each do |game|
      home_away_against[:hga][game.home_team_id] += game.away_goals
      home_away_against[:aga][game.away_team_id] += game.home_goals
    end
    home_away_against
  end

  def tot_goals_against
    total_goals_against = {}
    home_away_goals_against[:hga].each do |id, hga|
      total_goals_against[id] = (hga + home_away_goals_against[:aga][id])
    end
    total_goals_against
  end

  def games_won_game_team
    game_team_wins = Hash.new(0)
    @game_teams.each do |game|
      if game.won == 'TRUE'
        game_team_wins[game.team_id] += 1
      end
    end
    game_team_wins
  end

  def total_home_away_wins_by_team
    home_away_wins = {:hw => Hash.new(0), :aw => Hash.new(0)}
    @game_teams.each do |team|
      if team.won && team.hoa == 'home'
        home_away_wins[:hw][team.team_id] += 1
      elsif team.won && team.hoa == 'away'
        home_away_wins[:aw][team.team_id] += 1
      end
    end
    home_away_wins
  end

  def home_away_game_team_wins
    home_away_wins = {:hw => Hash.new(0), :aw => Hash.new(0)}
      @game_teams.find_all do |game|
        if game.won == 'TRUE' && game.hoa == 'home'
          home_away_wins[:hw][game.team_id] += 1
        elsif game.won == 'TRUE' && game.hoa == 'away'
          home_away_wins[:aw][game.team_id] += 1
        end
      end
    home_away_wins
  end

  def total_home_away_games_played
    total_home_away = {:hgp => Hash.new(0), :agp => Hash.new(0)}
    @game_teams.each do |game|
      if game.hoa == 'home'
        total_home_away[:hgp][game.team_id] += 1
      else
        total_home_away[:agp][game.team_id] += 1
      end
    end
    total_home_away
  end

  def percent_of_home_games_won
    percent_of_home_games_won = Hash.new(0)
      home_away_game_team_wins[:hw].map do |team_id, home_wins|
        percent_of_home_games_won[team_id] =
          home_wins/total_home_away_games_played[:hgp][team_id].to_f
    end
    percent_of_home_games_won
  end

  def percent_of_away_games_won
    percent_of_away_games_won = Hash.new(0)
      home_away_game_team_wins[:aw].map do |team_id, away_wins|
        percent_of_away_games_won[team_id] =
          away_wins/total_home_away_games_played[:agp][team_id].to_f
    end
    percent_of_away_games_won
  end

  def difference_home_vs_away_won
    difference_home_vs_away_won = Hash.new(0)
      percent_of_home_games_won.map do |team_id, home_win|
      difference_home_vs_away_won[team_id] = home_win - percent_of_away_games_won[team_id]
    end
    difference_home_vs_away_won
  end
end
