class GraderJob < ActiveJob::Base
  def perform (id)
    @submission = Submission.find_by_id id

    # Just consider this job done if the submission
    # does not exist for whatever reason.

    return true if (@submission.nil? or @submission.graded)

    # It is important to update this now, so that if the grader
    # fails at somepoint, we will know since the graded value
    # will still be false.

    @submission.update graded_date: Time.now

    # For each of the test drivers, run the submission

    @submission.assessment.test_drivers.each do |t|
      @feedback_file = generate_feedback_file_name
      @worker        = Grader::Worker.new
      result         = TestDriverResult.new submission: @submission, test_driver: t

      # Put the student's submission, and the instructor's
      # driver into the container.

      @worker.upload_files [@submission.file.url]

      upload_driver t.file.url

      # Run the driver, supplying the name of the expected
      # feedback file to the driver.

      output = @worker.exec_cmd ['bash', "#{File.basename(t.file.url, '.*')}.sh", @feedback_file]

      # Pull the feedback (if any) from the container.

      feedback = pull_feedback(t.points)

      # We will use the grade supplied by the feedback if there is one.

      if not feedback.nil?
        result.grade    = feedback['grade'].ceil
        result.feedback = feedback['comments']
      end

      # Store all result data into the result object for saving.

      result.grade ||= (t.points if output[:success]) || 0
      result.output  = check_output output[:stdout]
      result.error   = check_output output[:stderr]
      result.success = output[:success]

      result.save

      # Now we need to pull the expected output files from the container (assuming there are any).

      files = t.test_driver_files
      path  = File.dirname @submission.file.url

      if files.length > 0
        files.each do |f|

          # Pull the file from the worker (assuming it was created)

          tmp_path = @worker.get_file f.name

          # If the expected file was generated

          if tmp_path != false
            # Move the file from the temp location to the final storage location

            fqn = "#{path}/#{f.name}"
            FileUtils.copy tmp_path, fqn

            result_file = TestDriverResultFile.new test_driver_result: result, test_driver_file: f, path: fqn, grade: f.points
            result_file.save
          end
        end
      end

      @worker.close
    end

    # Calculate a grade, then set submission as graded

    @submission.calculate_grade
    @submission.update graded: true
  end

  private
    def generate_feedback_file_name
      "#{('a'..'z').to_a.shuffle![0, 15].join}.yml"
    end

    def upload_driver (f)
      @worker.upload_files [f]

      @worker.exec_cmd(['unzip', '-j', File.basename(f)]) if File.extname(f) == '.zip'
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
      # Make sure the output from the program does not exceed the maximum allowed length

      if value.bytesize > Rails.configuration.grader['max_bytes']
        return value.byteslice(0, Rails.configuration.grader['max_bytes']) << " (Truncated to #{Rails.configuration.grader['max_bytes']} bytes)"
      end
      
      value
    end
end
