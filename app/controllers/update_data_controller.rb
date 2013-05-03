class UpdateDataController < ApplicationController
  def update
    data = JSON.parse(params[:data])
    Jobs.enqueue(Jobs::ParseStockData.new(params[:data]))
    render :inline => "Success!"
  end
end
