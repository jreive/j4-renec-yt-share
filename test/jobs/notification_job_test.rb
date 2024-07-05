require "test_helper"

class NotificationJobTest < ActiveJob::TestCase
  include ActiveJob::TestHelper

  def test_jobs
    assert_enqueued_jobs 0

    NotificationJob.perform_later('david')
    assert_enqueued_with(job: NotificationJob, args: ['david'])
    assert_enqueued_jobs 1

    NotificationJob.perform_later('abdelkader')
    assert_enqueued_jobs 2

    NotificationJob.set(wait_until: Date.tomorrow.noon, queue: "queue").perform_later
    assert_enqueued_with(at: Date.tomorrow.noon, queue: "queue")
  end

end
