require 'spec_helper'

describe Micropost do
  describe "instance" do
    subject { Micropost.new }

    it "responds to user" do
      expect(subject).to respond_to(:user)
    end

    it "responds to content" do
      expect(subject).to respond_to(:content)
    end

    context "when content is 140 characters or less" do
      before { subject.content = "a" * 140 }

      it "is valid" do
        expect(subject).to be_valid
      end
    end

    context "when content is more than 140 characters" do
      before { subject.content = "a" * 141 }

      it "is invalid" do
        expect(subject).not_to be_valid
      end
    end
  end
end
