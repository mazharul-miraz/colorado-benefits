class FormNavigation
  MAIN = [
    HowItWorksController,
    DemoConfirmationController,
    WhatIsYourZipCodeController,
    WhatCountyDoYouLiveInController,
    OverlappingZipCodeController,
    NotYetSupportedController,
    ChangeTypeController,
    WhoHadChangeController,
    ClientInfoController,
    # Job termination questions
    TellUsAboutTheLostJobController,
    TellUsMoreAboutTheLostJobController,
    # New job questions
    SelfEmployedController,
    NotYetSupportedController,
    TellUsAboutTheNewJobController,
    TellUsMoreAboutTheNewJobController,
    HowMuchWillYouMakeController,
    # Change in hours questions
    TellUsAboutChangeInHoursJobController,
    TellUsAboutChangeInHoursController,
    # Documents
    DoYouHaveDocumentsController,
    AddDocumentsController,
    # Closing
    AnyOtherChangesController,
    TextMessageConsentController,
    WantACopyController,
    SignSubmitController,
    SuccessController,
  ].freeze

  class << self
    delegate :first, to: :form_controllers

    def form_controllers
      MAIN
    end
  end

  delegate :form_controllers, to: :class

  def initialize(form_controller)
    @form_controller = form_controller
  end

  def next
    return unless index

    form_controllers_until_end = form_controllers[index + 1..-1]
    seek(form_controllers_until_end)
  end

  private

  def index
    form_controllers.index(@form_controller.class)
  end

  def seek(list)
    list.detect do |form_controller_class|
      form_controller_class.show?(@form_controller.current_report)
    end
  end
end
