require "rails_helper"

RSpec.describe ReportPdfBuilder do
  context "job termination" do
    it "creates a pdf from a Change Report" do
      report = ReportDecorator.new(
        create(:report_with_letter,
          :with_change,
          change_type: :job_termination,
          first_name: "Person",
          last_name: "McPeoples"),
      )

      raw_pdf = ReportPdfBuilder.new(report).run
      temp_file = write_raw_pdf_to_temp_file(source: raw_pdf)
      text_analysis = PDF::Inspector::Text.analyze(temp_file).strings.join.gsub("\n", " ")

      expect(text_analysis).to include("Person McPeoples")
      expect(text_analysis).to include("job termination")
    end
  end

  context "new job" do
    it "creates a pdf from a Change Report" do
      report = ReportDecorator.new(
        create(:report_with_letter, :with_change, change_type: :new_job, first_name: "Person", last_name: "McPeoples"),
      )

      raw_pdf = ReportPdfBuilder.new(report).run
      temp_file = write_raw_pdf_to_temp_file(source: raw_pdf)
      text_analysis = PDF::Inspector::Text.analyze(temp_file).strings.join.gsub("\n", " ")

      expect(text_analysis).to include("Person McPeoples")
      expect(text_analysis).to include("new job")
    end
  end
end
