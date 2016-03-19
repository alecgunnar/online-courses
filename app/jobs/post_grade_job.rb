class PostGradeJob < ActiveJob::Base
  def perform (id)
    submission = Submission.find_by_id id

    return if submission.nil?

    provider = IMS::LTI::ToolProvider.new(submission.assessment.consumer.key, Rails.configuration.lti['secret'], {
      'lis_outcome_service_url' => submission.assessment.consumer.outcome_url,
      'lis_result_sourcedid'    => submission.result_sourcedid
    })

    provider.post_replace_result! submission.final_grade.decimal_result
  end
end
