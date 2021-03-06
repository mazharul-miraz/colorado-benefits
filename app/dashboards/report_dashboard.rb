require "administrate/base_dashboard"

class ReportDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    case_number: CaseNumberField,
    created_at: Field::DateTime,
    reported_changes: Field::HasMany.with_options(class_name: "Change"),
    phone_number: PhoneNumberField,
    signature: Field::String,
    submitted_at: Field::DateTime,
    updated_at: Field::DateTime,
    download_link: DownloadLinkField,
    sms_consent: SmsConsentField,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    case_number
    signature
    submitted_at
    download_link
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    created_at
    updated_at
    reported_changes
    case_number
    signature
    phone_number
    sms_consent
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  ].freeze

  # Overwrite this method to customize how change reports are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(report)
  #   "Report ##{report.id}"
  # end
end
