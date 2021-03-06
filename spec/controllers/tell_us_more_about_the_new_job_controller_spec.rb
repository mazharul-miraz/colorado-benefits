require "rails_helper"

RSpec.describe TellUsMoreAboutTheNewJobController do
  it_behaves_like "form controller successful update", {
    first_day_day: "15",
    first_day_month: "1",
    first_day_year: "2000",
    paid_yet: "yes",
  }, "new_job"
  it_behaves_like "form controller unsuccessful update"
  it_behaves_like "form controller new job behavior"
end
