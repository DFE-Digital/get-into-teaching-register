require "rails_helper"

RSpec.feature "Sign up for a teacher training adviser", type: :feature do
  context "a new candidate" do
    before do
      # Emulate an unsuccessful matchback response from the API.
      expect_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
        receive(:create_candidate_access_token)
        .and_raise(GetIntoTeachingApiClient::ApiError)
    end

    scenario "that is a returning teacher" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_text "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_text "Are you returning to teaching?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_text "Do you have your previous teacher reference number?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_text "What is your previous teacher reference number?"
      fill_in "Teacher reference number (optional)", with: "1234"
      click_on "Continue"

      expect(page).to have_text "Which main subject did you previously teach?"
      select "Psychology"
      click_on "Continue"

      expect(page).to have_text "Which subject would you like to teach if you return to teaching?"
      choose "Physics"
      click_on "Continue"

      expect(page).to have_text "Enter your date of birth"
      fill_in_date_of_birth_step
      click_on "Continue"

      expect(page).to have_text "Where do you live?"
      choose "UK"
      click_on "Continue"

      expect(page).to have_text "What is your address?"
      fill_in_address_step
      click_on "Continue"

      expect(page).to have_text "What is your telephone number?"
      fill_in "UK telephone number (optional)", with: "123456789"
      click_on "Continue"

      expect(page).to have_text "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_text "Read and accept the privacy policy"
      check "Accept the privacy policy"

      expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:sign_up_teacher_training_adviser_candidate).once

      click_on "Complete"

      expect(page).to have_text "Thank you"
      expect(page).to have_text "Sign up complete"
    end

    scenario "with an equivalent degree" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_text "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_text "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Do you have a degree?"
      choose "I have an equivalent qualification from another country"
      click_on "Continue"

      expect(page).to have_text "Which stage are you interested in teaching?"
      choose "Secondary"
      click_on "Continue"

      expect(page).to have_text "Which subject would you like to teach?"
      select "Physics"
      click_on "Continue"

      expect(page).to have_text "When do you want to start your teacher training?"
      select "2022"
      click_on "Continue"

      expect(page).to have_text "Enter your date of birth"
      fill_in_date_of_birth_step
      click_on "Continue"

      expect(page).to have_text "Where do you live?"
      choose "Overseas"
      click_on "Continue"

      expect(page).to have_text "Which country do you live in?"
      select "Argentina"
      click_on "Continue"

      expect(page).to have_text "You told us you live overseas"
      fill_in "Contact telephone number *", with: "1234567"
      select "(GMT-10:00) Hawaii"
      click_on "Continue"

      expect(page).to have_text "Choose a time"
      select_first_option "Select your preferred day and time for a callback"
      click_on "Continue"

      expect(page).to have_text "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_text "Read and accept the privacy policy"
      check "Accept the privacy policy"

      expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:sign_up_teacher_training_adviser_candidate).once

      click_on "Complete"

      expect(page).to have_text "Thank you"
      expect(page).to have_text "Sign up complete"
    end

    scenario "studying for a degree" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_text "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_text "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Do you have a degree?"
      choose "I'm studying for a degree"
      click_on "Continue"

      expect(page).to have_text "In which year are you studying?"
      choose "First year"
      click_on "Continue"

      expect(page).to have_text "What subject is your degree?"
      select "Maths"
      click_on "Continue"

      expect(page).to have_text "What degree class are you predicted to get?"
      select "2:2"
      click_on "Continue"

      expect(page).to have_text "Which stage are you interested in teaching?"
      choose "Primary"
      click_on "Continue"

      expect(page).to have_text "Do you have grade 4 (C) or above in English and maths GCSEs, or equivalent?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_text "Do you have grade 4 (C) or above in GCSE science, or equivalent?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_text "When do you want to start your teacher training?"
      select "2022"
      click_on "Continue"

      expect(page).to have_text "Enter your date of birth"
      fill_in_date_of_birth_step
      click_on "Continue"

      expect(page).to have_text "Where do you live?"
      choose "Overseas"
      click_on "Continue"

      expect(page).to have_text "Which country do you live in?"
      select "Argentina"
      click_on "Continue"

      expect(page).to have_text "What is your telephone number?"
      fill_in "Overseas telephone number (optional)", with: "123456789"
      click_on "Continue"

      expect(page).to have_text "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_text "Read and accept the privacy policy"
      check "Accept the privacy policy"

      expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:sign_up_teacher_training_adviser_candidate).once

      click_on "Complete"

      expect(page).to have_text "Thank you"
      expect(page).to have_text "Sign up complete"
    end

    scenario "without a degree" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_text "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_text "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Do you have a degree?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "If you do not have a degree"
      expect(page).to_not have_text "Continue"
    end

    scenario "without science GCSEs, primary" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_text "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_text "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Do you have a degree?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_text "What subject is your degree?"
      select "Maths"
      click_on "Continue"

      expect(page).to have_text "Which class is your degree?"
      select "2:2"
      click_on "Continue"

      expect(page).to have_text "Which stage are you interested in teaching?"
      choose "Primary"
      click_on "Continue"

      expect(page).to have_text "Do you have grade 4 (C) or above in English and maths GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Are you planning to retake either English or maths (or both) GCSEs, or equivalent?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_text "Do you have grade 4 (C) or above in GCSE science, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Are you planning to retake your science GCSE?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Get the right GCSEs or equivalent qualifications"
      expect(page).to_not have_text "Continue"
    end

    scenario "without english/maths GCSEs, primary" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_text "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_text "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Do you have a degree?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_text "What subject is your degree?"
      select "Maths"
      click_on "Continue"

      expect(page).to have_text "Which class is your degree?"
      select "2:2"
      click_on "Continue"

      expect(page).to have_text "Which stage are you interested in teaching?"
      choose "Primary"
      click_on "Continue"

      expect(page).to have_text "Do you have grade 4 (C) or above in English and maths GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Are you planning to retake either English or maths (or both) GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Get the right GCSEs or equivalent qualifications"
      expect(page).to_not have_text "Continue"
    end

    scenario "without GCSEs, secondary" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_text "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_text "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Do you have a degree?"
      choose "Yes"
      click_on "Continue"

      expect(page).to have_text "What subject is your degree?"
      select "Maths"
      click_on "Continue"

      expect(page).to have_text "Which class is your degree?"
      select "2:2"
      click_on "Continue"

      expect(page).to have_text "Which stage are you interested in teaching?"
      choose "Secondary"
      click_on "Continue"

      expect(page).to have_text "Do you have grade 4 (C) or above in English and maths GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Are you planning to retake either English or maths (or both) GCSEs, or equivalent?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Get the right GCSEs or equivalent qualifications"
      expect(page).to_not have_text "Continue"
    end
  end

  context "an existing candidate" do
    let(:valid_code) { "123456" }
    let(:invalid_code) { "111111" }
    let(:existing_candidate) do
      GetIntoTeachingApiClient::TeacherTrainingAdviserSignUp.new(
        preferredEducationPhaseId: TeacherTrainingAdviser::Steps::StageInterestedTeaching::OPTIONS[:secondary],
        addressLine1: "7 Main Street",
        addressCity: "Manchester",
        addressPostcode: "TE7 1NG",
        dateOfBirth: Date.new(1999, 4, 27),
        telephone: "123456789",
      )
    end

    before do
      allow_any_instance_of(GetIntoTeachingApiClient::CandidatesApi).to \
        receive(:create_candidate_access_token)
      allow_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:get_pre_filled_teacher_training_adviser_sign_up)
        .with(valid_code, anything)
        .and_return(existing_candidate)
      allow_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:get_pre_filled_teacher_training_adviser_sign_up)
        .with(invalid_code, anything)
        .and_raise(GetIntoTeachingApiClient::ApiError)
    end

    scenario "matchback" do
      visit teacher_training_adviser_steps_path

      expect(page).to have_text "About you"
      fill_in_identity_step
      click_on "Continue"

      expect(page).to have_text "Verify your email address"
      expect(page).to have_text "Enter the verification code sent to john@doe.com"
      click_on "resend verification"

      expect(page).to have_text "We've sent you another email."
      fill_in "teacher-training-adviser-steps-authenticate-timed-one-time-password-field", with: invalid_code
      click_on "Continue"

      expect(page).to have_text "Please enter the latest verification code sent to your email address"
      fill_in "teacher-training-adviser-steps-authenticate-timed-one-time-password-field-error", with: valid_code
      click_on "Continue"

      expect(page).to have_text "Are you returning to teaching?"
      choose "No"
      click_on "Continue"

      expect(page).to have_text "Do you have a degree?"
      choose "I have an equivalent qualification from another country"
      click_on "Continue"

      expect(page).to have_text "Which stage are you interested in teaching?"
      expect(find_field("Secondary")).to be_checked
      click_on "Continue"

      expect(page).to have_text "Which subject would you like to teach?"
      select "Physics"
      click_on "Continue"

      expect(page).to have_text "When do you want to start your teacher training?"
      select "2022"
      click_on "Continue"

      expect(page).to have_text "Enter your date of birth"
      expect(find_field("Day").value).to eq("27")
      expect(find_field("Month").value).to eq("4")
      expect(find_field("Year").value).to eq("1999")
      click_on "Continue"

      expect(page).to have_text "Where do you live?"
      choose "UK"
      click_on "Continue"

      expect(page).to have_text "What is your address?"
      expect(find_field("Address line 1").value).to eq("7 Main Street")
      expect(find_field("Town or City").value).to eq("Manchester")
      expect(find_field("Postcode").value).to eq("TE7 1NG")
      click_on "Continue"

      expect(page).to have_text "You told us you live in the United Kingdom"
      expect(find_field("Contact telephone number").value).to eq("123456789")
      select_first_option "Select your preferred day and time for a callback"
      click_on "Continue"

      expect(page).to have_text "Check your answers before you continue"
      click_on "Continue"

      expect(page).to have_text "Read and accept the privacy policy"
      check "Accept the privacy policy"

      expect_any_instance_of(GetIntoTeachingApiClient::TeacherTrainingAdviserApi).to \
        receive(:sign_up_teacher_training_adviser_candidate).once

      click_on "Complete"

      expect(page).to have_text "Thank you"
      expect(page).to have_text "Sign up complete"
    end
  end

  def fill_in_identity_step
    fill_in "First name", with: "John"
    fill_in "Surname", with: "Doe"
    fill_in "Email address", with: "john@doe.com"
  end

  def fill_in_date_of_birth_step
    fill_in "Day", with: "24"
    fill_in "Month", with: "03"
    fill_in "Year", with: "1966"
  end

  def fill_in_address_step
    fill_in "Address line 1", with: "7"
    fill_in "Address line 2 (optional)", with: "Main Street"
    fill_in "Town or City", with: "Edinburgh"
    fill_in "Postcode", with: "EH12 8JF"
  end

  def select_first_option(field_label)
    find_field(field_label).first("option").select_option
  end
end
