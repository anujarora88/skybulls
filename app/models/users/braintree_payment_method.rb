class Users::BraintreePaymentMethod < Users::PaymentMethod

  private

    def process_deposit(money)
      result = Braintree::Transaction.sale(
          :amount => format_amount(money),
          :customer_id => identifier
      )
      if result.success?
        Users::Deposit.create!(:identifier => result.transaction.id, :amount => money, :payment_method => self)
        true
      elsif result.transaction
        account.errors.add :base, "#{result.transaction.processor_response_code}: #{result.transaction.processor_response_text}"
        false
      else
        #check if this works!!
        account.errors.add :base, result.errors
        false
      end
    end

    def process_withdrawl(money)
      result = Braintree::Transaction.credit(
          :amount => format_amount(money),
          :customer_id => identifier
      )
      if result.success?
        Users::Withdrawl.create!(:identifier => result.transaction.id, :amount => money, :payment_method => self)
        true
      elsif result.transaction
        account.errors.add :base, "#{result.transaction.processor_response_code}: #{result.transaction.processor_response_text}"
        false
      else
        account.errors.add :base, result.errors
        false
      end

    end

  def format_amount(money)
    if money.is_a? Money
        if money.currency == Currency.new("USD")
          money.format(:symbol => false)
        else
          raise "invalid money object"
        end
    else
        raise "invalid money object"
    end
  end

end