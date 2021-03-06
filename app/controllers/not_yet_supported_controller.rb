class NotYetSupportedController < FormsController
  layout "off_ramp"

  def self.show_rule_sets(report)
    super << (!report.navigator.supported_county? || report.current_change&.change_navigator&.is_self_employed_yes?)
  end

  def form_class
    NullForm
  end
end
