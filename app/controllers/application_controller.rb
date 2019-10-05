require './config/environment'
require 'rack-flash'
require 'require_all'
class ApplicationController < ActionController::Base



  configure do
     set :public_folder, 'public'
     set :views, 'app/views'
     enable :sessions
     set :session_secret, "secret_password"
   end

  get '/' do
    erb :index
  end

helpers do

  def current_user
    @current_user ||=User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def redirect
    if !logged_in?
      flash[:message] = "You must be logged in."
      redirect to '/login'
    end
  end
end

end
