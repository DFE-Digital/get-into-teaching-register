module Wizard
  module Steps
    class Authenticate < ::Wizard::Step
      IDENTITY_ATTRS = %i[email first_name last_name date_of_birth].freeze

      attribute :timed_one_time_password

      validates :timed_one_time_password, length: { is: 6 },
                                          format: { with: /\A[0-9]*\z/ }
      validate :timed_one_time_password_is_correct, if: :perform_api_check?

      before_validation if: :timed_one_time_password do
        self.timed_one_time_password = timed_one_time_password.to_s.strip
      end

      def skipped?
        @store["authenticate"] != true
      end

      def save!
        @store["authenticated"] = false

        if valid?
          prepopulate_store
          @store["authenticated"] = true
        end

        super
      end

      def export
        {}
      end

      def reviewable_answers
        {}
      end

      def timed_one_time_password=(value)
        @totp_response = nil if value != timed_one_time_password

        super(value)
      end

      def candidate_identity_data
        @store.fetch(IDENTITY_ATTRS).transform_keys do |k|
          k.camelize(:lower).to_sym
        end
      end

    protected

      def perform_existing_candidate_request(_request)
        raise NotImplementedError, "subclass must define #perform_existing_candidate_request"
      end

    private

      def perform_api_check?
        timed_one_time_password_valid? && !@store["authenticated"]
      end

      def timed_one_time_password_valid?
        self.class.validators_on(:timed_one_time_password).each do |validator|
          validator.validate_each(self, :timed_one_time_password, timed_one_time_password)
        end
        errors.none?
      end

      def timed_one_time_password_is_correct
        request = GetIntoTeachingApiClient::ExistingCandidateRequest.new(candidate_identity_data)
        @totp_response ||= perform_existing_candidate_request(request)
      rescue GetIntoTeachingApiClient::ApiError
        errors.add(
          :timed_one_time_password,
          I18n.t("activemodel.errors.models.wizard/steps/authenticate.attributes.timed_one_time_password.invalid"),
        )
      end

      def prepopulate_store
        hash = @totp_response.to_hash.transform_keys { |k| k.to_s.underscore }
        @store.persist(hash.except(*@store.keys))
      end
    end
  end
end
