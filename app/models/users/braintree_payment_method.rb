class Users::BraintreePaymentMethod < Users::PaymentMethod

  private

    def process_deposit!(money)
      result = Braintree::Transaction.sale(
          :amount => format_amount(money),
          :customer_id => identifier
      )
      if result.success?
        Users::Deposit.create!(:identifier => result.transaction.id, :amount => money, :payment_method => self)
      else
        raise PaymentGatewayException.new(result.message)
      end
    end

    def process_withdrawl!(money)
      result = Braintree::Transaction.credit(
          :amount => format_amount(money),
          :customer_id => identifier
      )
      if result.success?
        Users::Withdrawl.create!(:identifier => result.transaction.id, :amount => money, :payment_method => self)
      else
        raise PaymentGatewayException.new(result.message)
      end

    end

  def format_amount(money)
    if money.is_a? Money
        if money.currency == Money::Currency.new("USD")
          money.format(:symbol => false)
        else
          raise "invalid money object"
        end
    else
        raise "invalid money object"
    end
  end

end