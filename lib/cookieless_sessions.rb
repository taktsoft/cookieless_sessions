require "cookieless_sessions/version"
require "cookieless_sessions/rails_32_patch"

module CookielessSessions
  module EnabledController
    extend ActiveSupport::Concern

  protected

    def default_url_options
      options = super.dup || {} # super.dup is very important here!

      if session_id.present?
        options[session_key] = session_id
      end

      return options
    end

    def session_key
      Rails.application.config.session_options[:key]
    end

    if Rails::VERSION::MAJOR < 4
      def session_id
        request.session_options[:id]
      end
    else
      def session_id
        request.session.id
      end
    end

    def session_is_not_cookie_only?
      Rails.application.config.session_options[:cookie_only] == false
    end
  end
end
