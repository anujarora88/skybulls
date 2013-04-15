class Users::CashierController < ApplicationController

  prepend_before_filter :initialize_instance_variables

  def index
    @deposit = Users::Deposit.new
    @deposit.amount = Money.new(1000)
    @withdrawl = Users::Withdrawl.new
  end

  def deposit
    amount = params[:users_deposit][:amount].to_i
    money_amount = Money.new(amount*100)
    begin
      @deposit = current_user.account.create_payment_method_and_make_payment!
      (params, money_amount)
    rescue PaymentGatewayException => pge
      @deposit.amount = money_amount
      @deposit.errors.add(:base, pge.message)
      render 'index'
      return
    end
    redirect_to :action => :index, :notice => "Success"
  end

  def withdrawl
  end

  private

    def initialize_instance_variables
      @deposit = Users::Deposit.new
      @deposit.amount = Money.new(1000)
      @withdrawl = Users::Withdrawl.new
    end
end
