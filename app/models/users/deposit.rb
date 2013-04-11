module Users
  class Deposit < Transaction

    private

      def update_balance
        account.balance = account.balance + amount
        account.save!
      end

  end
end
