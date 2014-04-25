require 'spec_helper'
require 'support/cookieless_controller'

describe CookielessController do

  it "includes default_url_options from superclass" do
    ApplicationController.send(:define_method, :default_url_options, -> {
        { application_controller_option: 1337 }
      })

    controller.send(:default_url_options).should include(:application_controller_option)
  end

  it "includes session_key in default_url_options" do
    controller.send(:default_url_options).should include(rails_app_session_key)
  end

  it "doesn't include session_key in default_url_options if session_id isn't present" do
    controller.stub(:session_id).and_return(nil)

    controller.send(:default_url_options).should_not include(rails_app_session_key)
  end

  it "generates pathes with session_key=session_id in params" do
    controller.stub(:session_key).and_return('some_session_key')
    controller.stub(:session_id).and_return('some_session_id')

    controller.root_path.should include("some_session_key=some_session_id")
  end

  it "generates urls with session_key=session_id in params" do
    controller.stub(:session_key).and_return('some_session_key')
    controller.stub(:session_id).and_return('some_session_id')

    controller.redirect_to_root_url.should include("some_session_key=some_session_id")
  end

end
