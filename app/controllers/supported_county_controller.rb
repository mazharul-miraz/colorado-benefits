class SupportedCountyController < FormsController
  def self.show_rule_sets(change_report)
    super << ShowRules.must_have_supported_county(change_report)
  end

  def form_class
    NullForm
  end
end