class ApplicationController < ActionController::Base
  include SessionsHelper

  WillPaginate.per_page = 25

  before_action :set_last_seen_at, if: proc { logged_in? }


  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def set_last_seen_at
      current_user.update_column(:last_seen_at, Time.now)
    end

end
