class Users::CashierController < Users::AbstractController

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
      if @payment_method && @payment_method.deposit_allowed? && PaypalAdaptivePayments.preapproval_valid_for_amount?(@payment_method.identifier, amount)
        @payment_method.make_deposit!(money_amount, @return_url_hash)
      else
        preapproval_key = PaypalAdaptivePayments.setup_preapproved_payment!(amount, users_preapproval_success_url, users_preapproval_failure_url)
        if @payment_method
          @payment_method.identifier = preapproval_key
          @payment_method.pending_approval = true
          @payment_method.save!
        else
          @payment_method = Users::PaypalPaymentMethod.create!(:account => current_user.account, :type => Users::PaymentMethod.type_paypal,
                                                               :identifier => preapproval_key, :pending_approval => true)
        end
        redirect_to paypal_preapproval_url(preapproval_key)
        return
      end
    rescue PaymentException => pge
      @deposit.amount = money_amount
      @deposit.errors.add(:base, pge.message)
      render 'index'
      return
    end

    redirect_to :action => :index
  end

  def withdrawl
    amount = params[:users_withdrawl][:amount].to_i
    money_amount = Money.new(amount*100)

    @payment_method.make_withdrawl!(money_amount, @return_url_hash )
    redirect_to :action => :index
  end

  def preapproval_success
    details = PaypalAdaptivePayments.get_preapproval_details(@payment_method.identifier)
    if @payment_method.pending_approval?
      @payment_method.make_deposit!(Money.new(details.maxAmountPerPayment * 100), @return_url_hash)
      @payment_method.update_attributes!(pending_approval: false)
    end
    redirect_to :action => :index
  end

  def preapproval_failure
    @payment_method.identifier = nil
    @payment_method.pending_approval = false
    @payment_method.save!
    redirect_to :action => :index
  end

  private

    def initialize_instance_variables
      @deposit = Users::Deposit.new
      @deposit.amount = Money.new(1000)
      @withdrawl = Users::Withdrawl.new
      @payment_method = current_user.account.payment_method
      @return_url_hash =  {return_url: users_preapproval_success_url, cancel_url: users_preapproval_failure_url }

    end

    def paypal_preapproval_url(key)
      Rails.configuration.paypal_preapproval_key_url + key
    end
end
