module Users
  class AbstractController < ApplicationController

    append_before_filter :initialize_pinned_stocks
    prepend_before_filter :authenticate_user!

    private

      def initialize_pinned_stocks
        @pinned_stocks = Stock.all
      end


  end
end