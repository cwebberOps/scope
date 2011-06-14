class AdminController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def index
    menu
    render('menu')
  end

  def menu
  end

  def login
  end

  def attempt_login
    authorized_user = Teacher.authenticate(params[:username],params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      session[:is_admin] = authorized_user.is_admin
      flash[:notice] = "Welcome to Scope"
      redirect_to(:action => 'menu')
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    session[:is_admin] = nil
    flash[:notice] = "You have been logged out"
    redirect_to(:action => 'login')
  end

end
