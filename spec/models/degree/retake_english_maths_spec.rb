require "rails_helper"

RSpec.describe Degree::RetakeEnglishMaths do
  let(:yes) { build(:degree_retake_english_maths) }
  let(:no) { build(:degree_retake_english_maths, retaking_english_maths: RetakeEnglishMaths::OPTIONS[:no]) }

  describe "#next_step" do
    context "when answer is yes" do
      it "returns the correct option" do
        expect(yes.next_step).to eq("degree/subject_interested_teaching")
      end
    end

    context "when answer is no" do
      it "returns the correct option" do
        expect(no.next_step).to eq("qualification_required")
      end
    end
  end
end
