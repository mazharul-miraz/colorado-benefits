class TellUsAboutYourselfForm < Form
  set_attributes_for :member, :name, :ssn, :birthday_year, :birthday_month, :birthday_day
  set_attributes_for :change_report, :phone_number, :case_number

  before_validation -> { strip_dashes(:phone_number) }
  before_validation -> { strip_dashes(:ssn) }

  validates_presence_of :name, message: "Please add your name."
  validates :phone_number, ten_digit_phone_number: true
  validates :ssn, length: { is: 9, message: "Please add a 9 digit social security number", allow_blank: true }
  attr_internal_reader :birthday
  validates :birthday, date: true

  def save
    change_report.update(attributes_for(:change_report))

    if change_report.member.present?
      change_report.member.update(member_data)
    else
      change_report.create_member(member_data)
    end
  end

  def self.existing_attributes(change_report)
    if change_report.member.present?
      attributes = change_report.attributes.merge(change_report.member.attributes)
      %i[year month day].each do |sym|
        attributes["birthday_#{sym}"] = change_report.member.birthday.try(sym)
      end
      attributes[:ssn] = change_report.member.ssn
      HashWithIndifferentAccess.new(attributes)
    else
      {}
    end
  end

  private

  def member_data
    attributes = attributes_for(:member)
    attributes[:birthday] = to_datetime(birthday_year, birthday_month, birthday_day)
    attributes.except(
      :birthday_year,
      :birthday_month,
      :birthday_day,
    )
  end
end
