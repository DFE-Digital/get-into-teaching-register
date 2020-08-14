require "rails_helper"

RSpec.describe PagesController, type: :request do
  let(:policy_id) { SecureRandom.uuid }
  let(:policy) { GetIntoTeachingApiClient::PrivacyPolicy.new(id: policy_id, text: "Latest privacy policy") }

  describe "get /privacy_policy" do
    context "viewing the latest privacy policy" do
      before do
        allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to receive(:get_latest_privacy_policy).and_return(policy)
      end

      subject do
        get privacy_policy_path
        response
      end

      include_examples "policy_views"
    end

    context "viewing a specific privacy policy" do
      subject do
        get privacy_policy_path(id: policy.id)
        response
      end

      before do
        allow_any_instance_of(GetIntoTeachingApiClient::PrivacyPoliciesApi).to receive(:get_privacy_policy).with(policy.id).and_return(policy)
      end

      include_examples "policy_views"
      it "sets the session var" do
        expect(subject.request.session["privacy_policy_id"]).to eq(policy_id)
      end
    end
  end
end
