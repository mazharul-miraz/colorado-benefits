class Change < ApplicationRecord
  belongs_to :report

  enum change_type: { unfilled: 0, job_termination: 1, new_job: 2, change_in_hours: 3 }, _prefix: :change_type
  enum paid_yet: { unfilled: 0, yes: 1, no: 2 }, _prefix: :paid_yet
  enum same_hours: { unfilled: 0, yes: 1, no: 2 }, _prefix: :same_hours
end
