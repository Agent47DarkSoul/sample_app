require 'spec_helper'

describe "Authentication API" do
  describe "GET /signin page" do
    before { get signin_path }

    it "should visit signin page" do
      response.status.should be(200)
    end
  end
end