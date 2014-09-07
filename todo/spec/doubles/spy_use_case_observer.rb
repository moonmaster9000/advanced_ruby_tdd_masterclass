class SpyUseCaseObserver
  def use_case_succeeded(*)
    @observed_success = true
    @failed_validations = nil
  end

  def validation_failed(failed_validations:)
    @failed_validations = failed_validations
  end

  def has_observed_use_case_success?
    @observed_success
  end

  def has_observed_validation_failure?(failure_message)
    failed_validations.include? failure_message
  end

  private
  def failed_validations
    @failed_validations ||= []
  end
end
