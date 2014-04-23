require "cookieless_sessions/version"

module CookielessSessions

  module EnabledController
    extend ActiveSupport::Concern

    included do
      append_before_filter :apply_default_url_options
    end

    private

    def apply_default_url_options
      owner_class = method(:default_url_options).owner
      unless owner_class.class_variable_defined?(:@@already_cookielessed)
        owner_class.send(:alias_method, :original_default_url_options, :default_url_options)
        owner_class.send(:remove_method, :default_url_options)
        owner_class.send(:define_method, :default_url_options, default_url_options_block)
        owner_class.class_variable_set(:@@already_cookielessed, true)
      end
    end

    def default_url_options_block
      return Proc.new do
        options = original_default_url_options || {}
        options[session_key] = request.session_options[:id] ### FIXME testen ob dies immer neu evaluiert wird - die ID muss pro aufruf neu eingelesen werden!!
        options
      end
    end

    def session_key
      "_aktionsmodule_session".intern
    end

  end
end
