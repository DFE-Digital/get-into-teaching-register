require 'rails_helper'

RSpec.describe Degree::UkOrOverseas do
  let(:uk) { build(:degree_uk_or_overseas) }
  let(:overseas) { build(:degree_uk_or_overseas, :overseas) }

  describe "#next_step" do
    context "when answer is uk" do
      it "returns the correct option" do
        expect(uk.next_step).to eq("degree/uk_candidate")
      end
    end

    context "when answer is overseas" do
      it "returns the correct option" do
        expect(overseas.next_step).to eq("degree/overseas_candidate")
      end
    end
  end
end
