module Users
  class PaypalPaymentMethod < PaymentMethod

    def deposit_allowed?
      !identifier.nil?
    end

    private

      def process_deposit!(money, params_hash)
        key = PaypalAdaptivePayments.deposit!(identifier, format_amount(money), params_hash[:return_url], params_hash[:cancel_url] )
        Users::Deposit.create!(:identifier => key, :amount => money, :payment_method => self)

      end

      def process_withdrawl!(money, params_hash)
        key = PaypalAdaptivePayments.withdraw!(format_amount(money), account.user.email, params_hash[:return_url], params_hash[:cancel_url] )
        Users::Withdrawl.create!(:identifier => key, :amount => money, :payment_method => self)
      end

      def format_amount(money)
        if money.is_a? Money
          if money.currency == Money::Currency.new("USD")
            money.format(:symbol => false)
          else
            raise PaymentException.new("Invalid money object")
          end
        else
          raise PaymentException.new("Invalid money object")
        end
      end
  end
end