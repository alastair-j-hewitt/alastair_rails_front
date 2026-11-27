require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "root renders the home page" do
    get root_url
    assert_response :success
  end

  test "each step of the flow renders" do
    [home_url, scanner_url, confirmation_url, pin_url].each do |url|
      get url
      assert_response :success, "expected #{url} to render"
    end
  end

  test "scanner loads Instascan from this app, not rawgit" do
    get scanner_url
    assert_includes response.body, "/js/instascan.min.js"
    assert_not_includes response.body, "rawgit.com"
  end

  test "scanned content is never written with document.write" do
    get scanner_url
    assert_not_includes response.body, "document.write"
  end

  test "summary accepts a well-formed PIN by POST" do
    post summary_url, params: { pin: "1234" }
    assert_response :success
    assert_includes response.body, "Payment authorized"
  end

  test "summary rejects a malformed PIN" do
    post summary_url, params: { pin: "12ab" }
    assert_response :unprocessable_entity
  end

  test "the PIN cannot be submitted by GET" do
    assert_raises(ActionController::RoutingError) do
      get "/summary", params: { pin: "1234" }
    end
  end
end
