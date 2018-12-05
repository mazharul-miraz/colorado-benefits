require "rails_helper"

RSpec.describe TextMessageConsentController do
  it_behaves_like "form controller base behavior"
  it_behaves_like "form controller successful update", { consent_to_sms: "yes" }

  describe "show?" do
    context "when client is submitting on behalf of someone" do
      it "returns false" do
        navigator = build(:navigator, submitting_for: "other_member")
        report = create(:report, phone_number: "5555551234", navigator: navigator)

        show_form = TextMessageConsentController.show?(report)
        expect(show_form).to eq(false)
      end
    end

    context "when client is submitting for themselves" do
      context "when phone number has not been provided" do
        it "returns false" do
          navigator = build(:navigator, submitting_for: "self")
          report = create(:report, phone_number: nil, navigator: navigator)

          show_form = TextMessageConsentController.show?(report)
          expect(show_form).to eq(false)
        end
      end

      context "when phone number has been provided" do
        it "returns true" do
          navigator = build(:navigator, submitting_for: "self")
          report = create(:report, phone_number: "5555551234", navigator: navigator)

          show_form = TextMessageConsentController.show?(report)
          expect(show_form).to eq(true)
        end
      end
    end
  end

  describe "edit" do
    it "assigns existing attributes" do
      current_report = create(:report, :with_metadata, consent_to_sms: "yes")
      session[:current_report_id] = current_report.id

      get :edit

      form = assigns(:form)

      expect(form.consent_to_sms).to eq("yes")
    end
  end
end
