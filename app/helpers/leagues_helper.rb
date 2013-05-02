module LeaguesHelper

  def league_commission_string(league)
    if league.commission.nil?
      0
    else
      league.commission/100*league.buy_in
    end

  end

  def html_display_name(league)
    time_string = league.start_time.strftime("#{league.start_time.day.ordinalize} %b %Y")
    content_tag :strong, league.title

    "#{league.title} - $#{league.buy_in} #{league.category} #{time_string}"
  end

end
