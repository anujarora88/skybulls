module Jobs
  class SaveSearchedStock < Struct.new(:user_id, :stock_id, :recently_searched)

    def perform
      user = User.find(user_id)
      stock = Stock.find(stock_id)
      user.add_pinned_stock!(stock, recently_searched)
    end
  end
end