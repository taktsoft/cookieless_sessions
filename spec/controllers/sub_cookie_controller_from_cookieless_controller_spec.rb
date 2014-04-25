require 'spec_helper'
require 'support/cookieless_controller'


class SubCookieController < CookielessController

  def index
    render text: "SubCookieController#Index"
  end

protected

  def default_url_options
    super.except(session_key)
  end
end


describe SubCookieController do

  it "doesn't include session_key in default_url_options" do
    controller.stub(:session_key).and_return('some_session_key')
    controller.stub(:session_id).and_return('some_session_id')

    controller.send(:default_url_options).should_not include('some_session_key')
  end

  it "doesn't include session_key=session_id in generated path or url" do
    controller.stub(:session_key).and_return('some_session_key')
    controller.stub(:session_id).and_return('some_session_id')

    controller.root_path.should_not include("some_session_key=some_session_id")
    controller.root_url.should_not include("some_session_key=some_session_id")
  end

end