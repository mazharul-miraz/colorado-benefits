require "rails_helper"

RSpec.describe Navigator do
  describe ".supported_county?" do
    let(:report) { build(:report) }

    context "with selected county location of arapahoe" do
      it "returns true" do
        navigator = build(:navigator,
                           selected_county_location: :arapahoe,
                           report: report)

        expect(navigator.supported_county?).to be_truthy
      end
    end

    context "with county from address of Arapahoe County" do
      it "returns true" do
        navigator = build(:navigator,
                           county_from_address: "Arapahoe County",
                           report: report)

        expect(navigator.supported_county?).to be_truthy
      end
    end

    context "with neither selected county location nor county from address matching arapahoe" do
      it "returns false" do
        navigator = build(:navigator,
                           selected_county_location: :not_sure,
                           county_from_address: "Jefferson County",
                           report: report)

        expect(navigator.supported_county?).to be_falsey
      end
    end
  end
end