require 'spec_helper'

describe UsersHelper do
  describe "#gravatar_for" do
    let(:user) { build(:user) }

    it "returns an image tag" do
      expect(gravatar_for(user, size: 80)).to match(/img/)
    end

    it "returns img with url containing size parameter" do
      expect(gravatar_for(user, size: 80)).to match(/s=80/)
    end
  end
end