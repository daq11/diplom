class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :reset_session
  before_filter :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic('') do |username, password|
      if username == 'tutor' && password == 'tutor'
        session[:user] = 'tutor'
        true
      elsif username == 'stud1' && password == 'stud1'
        session[:user] = 'stud1'
        true
      elsif username == 'stud2' && password == 'stud2'
        session[:user] = 'stud2'
        true
      else
        false
      end
    end
  end

  def check_auth
    session.inspect =~ /"HTTP_COOKIE"=>"(.*?)"/
    if $1 =~ /_session_id=.*_session_id=./
      render text: 'Вам необходимо удалить куку _session_id для stud_online' and return
    end
    @current_user = User.find_by_login(session[:user])
  end

end
