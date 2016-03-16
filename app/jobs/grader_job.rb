class GraderJob < ActiveJob::Base
  def perform (id)
    submission = Submission.find_by_id id

    return if submission.nil?

    submission.assessment.test_drivers.each do |t|
      worker = Grader::Worker.new
      result = TestDriverResult.new

      result.submission  = submission
      result.test_driver = t

      worker.upload_files ["#{submission.file.url}", "#{Rails.root}/spikes/#{t.name}"]
      output = worker.exec_cmd(['bash', t.name])

      result.grade   = t.points if output[:success]
      result.output  = check_output output[:stdout]
      result.error   = check_output output[:stderr]
      result.success = output[:success]

      result.save!

      files = t.test_driver_files
      path  = File.dirname(submission.file.url)

      if files.length > 0
        files.each do |f|
          tmp_path = worker.get_file(f.name)

          if tmp_path != false
            fqn = "#{path}/#{f.name}"
            FileUtils.copy tmp_path, fqn

            result_file = TestDriverResultFile.new test_driver_result: result, test_driver_file: f, path: fqn, grade: f.points
            result_file.save!
          end
        end
      end

      worker.close
    end

    submission.update graded: true
  end

  private
    def check_output (value)
      if value.bytesize > Rails.configuration.grader['max_bytes']
        value.byteslice(0, Rails.configuration.grader['max_bytes']) << " (Truncated to #{Rails.configuration.grader['max_bytes']} bytes)"
      else
        value
      end
    end
end
