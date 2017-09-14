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
    allow(controller).to receive(:session_key).and_return('some_session_key')
    allow(controller).to receive(:session_id).and_return('some_session_id')

    expect(controller.send(:default_url_options)).not_to include('some_session_key')
  end

  it "doesn't include session_key=session_id in generated path or url" do
    allow(controller).to receive(:session_key).and_return('some_session_key')
    allow(controller).to receive(:session_id).and_return('some_session_id')

    expect(controller.root_path).not_to include("some_session_key=some_session_id")
    expect(controller.root_url).not_to include("some_session_key=some_session_id")
  end

end