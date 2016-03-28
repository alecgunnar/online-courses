class GraderJob < ActiveJob::Base
  def perform (id)
    @submission = Submission.find_by_id id

    return if @submission.nil?

    @submission.assessment.test_drivers.each do |t|
      @feedback_file = generate_feedback_file_name
      @worker        = Grader::Worker.new
      result         = TestDriverResult.new

      result.submission  = @submission
      result.test_driver = t

      @worker.upload_files [@submission.file.url, t.file.url]
      output = @worker.exec_cmd ['bash', File.basename(t.file.url), @feedback_file]

      feedback = pull_feedback(t.points)

      if feedback != false
        result.grade = feedback['grade']
      else
        result.grade = (t.points if output[:success]) || 0
      end

      result.output   = check_output output[:stdout]
      result.error    = check_output output[:stderr]
      result.feedback = feedback != false ? feedback['comments'] : ''
      result.success  = output[:success]

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
      name = ('a'..'z').to_a.shuffle![0, 15].join

      "#{name}.yml"
    end

    def pull_feedback (pts)
      file = @worker.get_file @feedback_file

      return false if not file

      begin
        feedback = YAML.load_file file
        
        if feedback.has_key? 'pass' and feedback.has_key? 'fail'
          feedback['grade'] = pts * (feedback['pass'].to_d / (feedback['pass'] + feedback['fail']))
        end

        feedback['comments'] = '' unless feedback.has_key? 'comments'

        return feedback
      rescue Psych::SyntaxError
        false
      end
    end

    def check_output (value)
      if value.bytesize > Rails.configuration.grader['max_bytes']
        value.byteslice(0, Rails.configuration.grader['max_bytes']) << " (Truncated to #{Rails.configuration.grader['max_bytes']} bytes)"
      else
        value
      end
    end
end
