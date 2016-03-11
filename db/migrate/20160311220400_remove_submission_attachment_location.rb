require_relative '20160310195316_add_attachment_to_submission'

class RemoveSubmissionAttachmentLocation < ActiveRecord::Migration
  def change
  	revert AddAttachmentToSubmission
  end
end
