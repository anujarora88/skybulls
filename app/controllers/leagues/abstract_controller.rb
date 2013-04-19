module Leagues
  class AbstractController < ApplicationController

    prepend_before_filter :initialize_league

    private

      def initialize_league
        @user_league_association = UserLeagueAssociation.find_by_league_id_and_user(params[:league_id], current_user)
        @league = @user_league_association.league
      end

  end
end
