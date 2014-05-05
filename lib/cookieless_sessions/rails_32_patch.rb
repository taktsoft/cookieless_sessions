module CookielessSessions
  module Rails32DestroyableSessionPatch
    def destroy
      clear
      options = @env[Rack::Session::Abstract::ENV_SESSION_OPTIONS_KEY] if @env
      options ||= {}
      options[:id] = @by.send(:destroy_session, @env, options[:id], options) if @by
      @loaded = false
    end
  end


  if Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR == 2
    ActiveSupport.on_load(:action_controller) do
      ::Rack::Session::Abstract::SessionHash.send(:include, Rails32DestroyableSessionPatch)
    end
  end
end