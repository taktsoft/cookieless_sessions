require 'spec_helper'
require 'support/cookieless_controller'

describe 'Cookieless', js: true do
  # We've set js: true because we want to use poltergeist in ths tests.

  context "with cookies disabled" do
    before(:each) do
      Capybara.current_session.driver.cookies_enabled = false
    end

    after(:each) do
      Capybara.current_session.driver.cookies_enabled = true
    end

    it "uses session_id from params" do
      visit root_path # visit first time to get a valid session_id

      session_id = extract_session_id_from_headers(page.response_headers)
      session_id.should be_present

      page.should have_content("'#{session_id}'")

      visit root_path(rails_app_session_key => "some_not_invalid_session_id")

      page.should have_no_content("'some_not_invalid_session_id'")
      page.should have_no_content("'#{session_id}'")

      visit root_path(rails_app_session_key => session_id)

      page.should have_content("'#{session_id}'")
    end

    it "returns a session_id with reset_session before" do
      visit reset_root_path

      session_id = extract_session_id_from_headers(page.response_headers)
      session_id.should be_present

      page.should have_content("'#{session_id}'")
    end
  end


  context "with cookies enabled" do
    before(:each) do
      Capybara.current_session.driver.cookies_enabled = true
    end

    after(:each) do
      Capybara.current_session.driver.cookies_enabled = true
    end

    it "uses session_id only from cookie" do
      visit root_path # visit first time to get a valid session_id.

      session_id = extract_session_id_from_headers(page.response_headers)
      session_id.should be_present

      page.should have_content("'#{session_id}'")

      visit root_path # visit second time. should keep session_id.
      page.should have_content("'#{session_id}'")

      page.reset_session!
      visit root_path # visit again with fresh session to get a new session_id.

      other_session_id = extract_session_id_from_headers(page.response_headers)
      other_session_id.should be_present

      page.should have_content("'#{other_session_id}'")

      visit root_path # visit fourth time. should keep other_session_id.
      page.should have_content("'#{other_session_id}'")

      visit root_path(rails_app_session_key => session_id) # visit with other session_id in get param than in cookie
      page.should have_content("'#{other_session_id}'")
    end
  end

end
