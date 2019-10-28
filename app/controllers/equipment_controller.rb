require './config/environment'
require 'rack-flash'
class EquipmentController < ApplicationController

  get '/equipment' do
    redirect_if_not_logged_in
    @equipment = Equipment.all
    erb :'/equipment/equipment'
  end

  get '/equipment/new' do
    redirect_if_not_logged_in
    erb :'/equipment/new'
  end

  post '/equipment' do
    if logged_in?
      if params["equipment"]["name"] == ""
        flash[:message] = "Please fill in all fields."
        redirect to '/equipment/new'
      else
        @user = current_user
       #  @book = Book.create(title: params["book"]["title"], author: params["book"]["author"], user_id: session[:user_id])
        @equipment = Equipment.create(name: params["equipment"]["name"], user_id: session[:user_id])
        if @equipment.save
          @user.equipment << @equipment
          redirect to '/equipment'
        else
          redirect to '/equipment/new'
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/equipment/:id' do
    redirect_if_not_logged_in
    @equipment = Equipment.find_by(id: params[:id])
    erb :'/equipment/show'
  end

  get '/equipment/:id/edit' do
    redirect_if_not_logged_in
    @equipment = Equipment.find_by(id: params[:id])
    if @equipment && @equipment.user == current_user
      erb :'/equipment/edit'
    else
      redirect to '/equipment'
    end
  end

  patch '/equipment/:id' do
    redirect_if_not_logged_in
    if params["equipment"]["name"] == ""
      redirect to '/equipment/:id/edit'
    else
      @equipment = Equipment.find_by(id: params[:id])
        if @equipment && @equipment.user == current_user
          if @equipment.update(equipment: params["equipment"]["name"])
            flash[:message] = "Equipment updated!"
            redirect to '/equipment'
          else
            redirect to '/equipment'
          end
        end
      end
    end

    delete '/equipment/:id/delete' do
      redirect_if_not_logged_in
      @equipment = Equipment.find_by(id: params["id"])
        if @equipment && @equipment.user == current_user
          @equipment.destroy
        end
        flash[:message] = "Your equipment ha been deleted."
        redirect to '/equipment'
      end
    end
