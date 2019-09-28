require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash


  #configure shit

  get '/' do
    erb :index
  end

  # helpers do

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
