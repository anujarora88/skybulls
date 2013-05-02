module Leagues
  class AbstractController < Users::AbstractController

    prepend_before_filter :initialize_league, :if => :user_signed_in?

    private

      def initialize_league
        @user_league_association = UserLeagueAssociation.find_by_league_id_and_user_id(params[:league_id], current_user.id)
        render_not_found(nil) unless @user_league_association
        @league = @user_league_association.league
      end

  end
end
