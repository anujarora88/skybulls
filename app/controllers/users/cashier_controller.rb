class Users::CashierController < ApplicationController


  def index
    @deposit = Users::Deposit.new
    @withdrawl = Users::Withdrawl.new
  end

  def deposit
  end

  def withdrawl
  end
end
