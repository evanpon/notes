class LoginController < ApplicationController
  skip_before_filter :authenticate
  
  def index
    
  end
  
  def verify
    sleep 0.5
    if params[:password] == SECURITY['password']
      session[:login_expires_at] = Time.now.to_i + 1.week
      session[:token] = authenticity_token
      redirect_to '/'
    else 
      redirect_to login_path
    end
  end
end