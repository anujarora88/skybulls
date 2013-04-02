module User
  class Withdrawl < Transaction

    private

      def update_balance
        account.balance = account.balance - amount
        account.save!
      end

  end
end
