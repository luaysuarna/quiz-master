require "rails_helper"

RSpec.feature "quizzes", :type => :feature do

  before :each do
    @question_1 = create(:question)
  end
  
  scenario 'Answer with correct answer', js: true do
    visit take_quiz_quizzes_path

    fill_in 'quiz[answer]', with: '17 Agustus'
    click_on('Submit')

    expect(page).to have_content('Good job!')
  end

  scenario 'Answer with incorrect answer', js: true do
    visit take_quiz_quizzes_path

    fill_in 'quiz[answer]', with: '17 September'
    click_on('Submit')

    expect(page).to have_content('Attantion!')
  end

end