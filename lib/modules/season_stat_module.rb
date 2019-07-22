module SeasonStat

  def surprise_bust_calculator(season_id)
    differential = {}
    win_percentage_regular_season(season_id).map do |id, pw|
      differential[id] = (win_percentage_post_season(season_id)[id] - pw).round(2)
    end
    differential.minmax_by {|id,dif| dif}
  end

  def biggest_bust(season_id)
    convert_id_to_name(surprise_bust_calculator(season_id)[0][0])
  end

  def biggest_surprise(season_id)
    convert_id_to_name(surprise_bust_calculator(season_id)[1][0])
  end
end
