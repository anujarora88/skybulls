class UpdateDataController < ApplicationController
  def update
    api_key = params[:apiKey]
    timestamp = params[:timestamp]
    confirm_key = params[:confirmKey]
    if api_key && timestamp && confirm_key && Time.now - Time.at(timestamp.to_i) < 10 && OpenSSL::HMAC.hexdigest('sha1', Rails.configuration.nodeapp_api_secret, timestamp+api_key) == confirm_key
      data = JSON.parse(params[:data])
      Jobs.enqueue(Jobs::ParseStockData.new(params[:data]))
      render :inline => "Success!"
    else
      render :inline => "Please provide a valid api key and confermation", :status => :unauthorized
    end


  end
end
