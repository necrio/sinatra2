class UsersController < ApplicationController

get '/users/:id' do
  redirect_if_not_logged_in
  @user = User.find_by(id: session[:user_id])
  erb :'/users/show'
end

get '/signup' do
  if !logged_in?
    erb :'/users/signup'
  else
    redirect to '/equipment'
  end
end

post '/signup' do
  @user = User.new(params)
  # requires unique email for all users
  if User.all.find{|user|user.email.downcase == params["email"].downcase||user.username.downcase == params["username"].downcase} #checks if existing user has matching email or username
   flash[:message] = "An account using that email already exists. Please try again."
     redirect to '/signup'
  else
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Hi there, #{@user.username}"
      redirect '/equipment'
    else
      flash[:message] = "Username, email, and password are required to create an account."
      redirect '/signup'
    end
  end
end

get '/login' do
  if !logged_in?
    erb :'/users/login'
  else
    redirect to '/equipment'
  end
end

post 'login' do
  @user = User.find_by(:username => params[:username])
  if @user && user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to '/equipment'
  else
    redirect to '/login'
  end
end

get 'logout' do
  if logged_in?
    session.destroy
    flash[:message] = "YOu are not OUT!"
    redirect to '/login'
  else
    redirect '/'
  end
end
end
