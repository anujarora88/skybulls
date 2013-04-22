module LeaguesHelper

  def league_commission_string(league)
    if league.commission.nil?
      0
    else
      league.commission/100*league.buy_in
    end

  end

end
