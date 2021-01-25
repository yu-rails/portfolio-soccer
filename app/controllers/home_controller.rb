class HomeController < ApplicationController
  skip_before_action :login_required
  before_action :forbid_login, {only: [:top]}
  def top
  end
  def about
    
  end
end
