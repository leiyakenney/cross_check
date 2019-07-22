module SeasonStat

  def most_hits(season)
      convert_id_to_name(minmax_hits(season)[1][0])
  end

  def fewest_hits(season)
      convert_id_to_name(minmax_hits(season)[0][0])
  end
  
end
