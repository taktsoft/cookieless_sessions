require 'spec_helper'
require 'support/cookieless_controller'

describe CookielessController do

  it "includes default_url_options from superclass" do
    ApplicationController.send(:define_method, :default_url_options, -> {
        { application_controller_option: 1337 }
      })

    expect(controller.send(:default_url_options)).to include(:application_controller_option)
  end

  it "includes session_key in default_url_options" do
    expect(controller.send(:default_url_options)).to include(rails_app_session_key)
  end

  it "doesn't include session_key in default_url_options if session_id isn't present" do
    allow(controller).to receive(:session_id).and_return(nil)

    expect(controller.send(:default_url_options)).not_to include(rails_app_session_key)
  end

  it "generates pathes with session_key=session_id in params" do
    allow(controller).to receive(:session_key).and_return('some_session_key')
    allow(controller).to receive(:session_id).and_return('some_session_id')

    expect(controller.root_path).to include("some_session_key=some_session_id")
  end

  it "generates urls with session_key=session_id in params" do
    allow(controller).to receive(:session_key).and_return('some_session_key')
    allow(controller).to receive(:session_id).and_return('some_session_id')

    expect(controller.redirect_to_root_url).to include("some_session_key=some_session_id")
  end

end
