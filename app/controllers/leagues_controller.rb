class LeaguesController < ApplicationController
  def index
    @exchanges = Exchange.all
    @leagues = League.where("start_time >= :start_time OR
      latest_registration_time >= :latest_registration_time", {start_time: Time.now, latest_registration_time: Time.now}).all

  end

  def show
  end

  def subscribe
  end

  def unsubscribe
  end
end
