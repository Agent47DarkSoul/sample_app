require 'spec_helper'

describe "Users" do
  describe "signup" do
    before { get signup_path }

    it "returns correct response" do
      expect(response.code).to eq("200")
    end
  end
end