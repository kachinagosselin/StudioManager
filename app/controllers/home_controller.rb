class HomeController < ApplicationController
  def index
    if current_user.present?
    if current_user.account.present?
    if current_user.account.studio.present?
        @studio = current_user.account.studio
    end
    end
    end
  end
end
