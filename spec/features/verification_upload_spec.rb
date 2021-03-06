require "rails_helper"

feature "Uploading verifications", js: true do
  before do
    visit "/"
    expect(page).to have_text "Report changes to your benefits case"
    expect(page).to have_title "Report changes to your Colorado benefits case"
    click_on "Start my report", match: :first

    expect(page).to have_text "Welcome! Here’s how reporting a change works"
    click_on "Start the form"

    fill_in "What's your zip code in Colorado?", with: "80046"
    click_on "Continue"

    expect(page).to have_text "What changed?"
    choose "Someone's hours or pay changed"
    proceed_with "Continue"

    expect(page).to have_text "Who had this change?"
    choose "Me"
    click_on "Continue"

    expect(page).to have_text "What is your name?"
    fill_in "What is your first name?", with: "Jane"
    fill_in "What is your last name?", with: "Doe"
    fill_in "What is your phone number?", with: "555-222-3333"
    select "January", from: "form[birthday_month]"
    select "1", from: "form[birthday_day]"
    select 20.years.ago.year.to_s, from: "form[birthday_year]"
    click_on "Continue"
  end

  scenario "add documents" do
    visit add_documents_screens_path
    page.attach_file("form[documents][]", Rails.root.join("spec", "fixtures", "image.jpg"), make_visible: true)
    expect(page).to have_text "image.jpg"

    click_on "Continue"

    expect(page).to_not have_text "Add your letter."

    visit add_documents_screens_path
    expect(page).to have_text "image.jpg"

    click_on "Continue"

    expect(page).to_not have_text "Add your letter."
  end

  scenario "delete documents" do
    visit add_documents_screens_path

    page.attach_file("form[documents][]", Rails.root.join("spec", "fixtures", "image.jpg"), make_visible: true)
    expect(page).to have_text "image.jpg"

    click_on "Delete"
    expect(page).to_not have_text "image.jpg"
    click_on "Continue"

    visit add_documents_screens_path
    expect(page).to_not have_text "image.jpg"

    page.attach_file("form[documents][]", Rails.root.join("spec", "fixtures", "image.jpg"), make_visible: true)
    expect(page).to have_text "image.jpg"

    click_on "Continue"
    visit add_documents_screens_path
    expect(page).to have_text "image.jpg"
    click_on "Delete"

    expect(page).to_not have_text "image.jpg"
  end
end
