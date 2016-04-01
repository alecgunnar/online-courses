class GraderJob < ActiveJob::Base
  def perform (id)
    @submission = Submission.find_by_id id

    # Just consider this job done if the submission
    # does not exist for whatever reason.
    return true if @submission.nil?

    @submission.assessment.test_drivers.each do |t|
      @feedback_file = generate_feedback_file_name
      @worker        = Grader::Worker.new
      result         = TestDriverResult.new submission: @submission, test_driver: t

      # Put the students submission, and the instructor's
      # driver into the container.
      @worker.upload_files [@submission.file.url, t.file.url]

      # Run the driver, supplying the name of the expected
      # feedback file to the driver.
      output = @worker.exec_cmd ['bash', File.basename(t.file.url), @feedback_file]

      # Pull the feedback (if any) from the container.
      feedback = pull_feedback(t.points)

      # We will use the grade supplied by the feedback.
      if not feedback.nil?
        result.grade    = feedback['grade'].ceil
        result.feedback = feedback['comments']
      end

      result.grade ||= (t.points if output[:success]) || 0
      result.output  = check_output output[:stdout]
      result.error   = check_output output[:stderr]
      result.success = output[:success]

      result.save

      files = t.test_driver_files
      path  = File.dirname @submission.file.url

      if files.length > 0
        files.each do |f|
          tmp_path = @worker.get_file f.name

          if tmp_path != false
            fqn = "#{path}/#{f.name}"
            FileUtils.copy tmp_path, fqn

            result_file = TestDriverResultFile.new test_driver_result: result, test_driver_file: f, path: fqn, grade: f.points
            result_file.save
          end
        end
      end

      @worker.close
    end

    @submission.calculate_grade
    @submission.update graded: true
  end

  private
    def generate_feedback_file_name
      "#{('a'..'z').to_a.shuffle![0, 15].join}.yml"
    end

    def pull_feedback (pts)
      file = @worker.get_file @feedback_file

      return nil if not file

      begin
        feedback = {
          grade:    0,
          comments: ''
        }.merge! YAML.load_file file
        
        if feedback.has_key? 'pass' and feedback.has_key? 'fail'
          feedback['grade'] = pts * (feedback['pass'].to_d / (feedback['pass'] + feedback['fail']))
        end

        feedback
      rescue Psych::SyntaxError
        nil
      end
    end

    def check_output (value)
      if value.bytesize > Rails.configuration.grader['max_bytes']
        return value.byteslice(0, Rails.configuration.grader['max_bytes']) << " (Truncated to #{Rails.configuration.grader['max_bytes']} bytes)"
      end
      
      value
    end
end
