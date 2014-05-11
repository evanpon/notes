class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authenticate
  
  def authenticate
    puts "#{Time.now.to_i} : #{session[:login_expires_at].to_i}"
    puts "#{session[:token]}"
    if Time.now.to_i < session[:login_expires_at].to_i &&
       session[:token] == authenticity_token
         true
    else
      redirect_to login_path
      false
    end
        
  end
  
  def authenticity_token
    Digest::SHA2.hexdigest(SECURITY['salt'] + session[:login_expires_at].to_s)
  end
end
