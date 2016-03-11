class GraderJob 
  include SuckerPunch::Job
  
  def perform (id)
    submission = Submission.find id

    submission.assessment.test_drivers.each do |t|
      worker = Grader::Worker.new
      result = TestDriverResult.new

      result.submission  = submission
      result.test_driver = t

      worker.upload_files ["#{submission.file.url}", "#{Rails.root}/spikes/#{t.name}"]
      output = worker.exec_cmd(['bash', t.name])

      result.grade  = t.points if output
      result.output = output ? output.strip! : 'Execution Failed!'

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
end
