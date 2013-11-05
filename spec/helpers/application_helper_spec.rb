require 'spec_helper'

describe ApplicationHelper do
  describe "#full_title" do
    let(:base_title) { /^Ruby on Rails Tutorials Sample App/ }

    context "with page title" do
      it "includes page title" do
        expect(full_title("foo")).to match(/foo/)
      end

      it "includes base title" do
        expect(full_title("foo")).to match(base_title)
      end
    end

    context "with no page title" do
      it "does not include separator" do
        expect(full_title("")).not_to match(/\|/)
      end

      it "includes base title" do
        expect(full_title("")).to match(base_title)
      end
    end
  end
end