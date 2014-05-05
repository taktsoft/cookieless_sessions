Rails.application.routes.draw do
  get "/cookieless" => "cookieless#index", as: :root
  get "/cookieless/reset" => "cookieless#reset_index", as: :reset_root
  get "/cookieless/redirect" => "cookieless#redirect_to_root", as: :redirect_to_root
end


class ApplicationController < ActionController::Base
end


class CookielessController < ApplicationController
  include CookielessSessions::EnabledController

  protect_from_forgery with: :exception

  def index
    session[:useless] = :content

    render text: "CookielessController#Index\r\nSession-Key: '#{session_key}'\r\nSession-ID: '#{session_id}'\r\nRails-Version: '#{Rails.version}'\r\n"
  end

  def reset_index
    reset_session

    render text: "CookielessController#Index\r\nSession-Key: '#{session_key}'\r\nSession-ID: '#{session_id}'\r\nRails-Version: '#{Rails.version}'\r\n"
  end

  def redirect_to_root
    redirect_to root_url
  end
end
