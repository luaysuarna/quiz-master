require "rails_helper"

RSpec.feature "questions", :type => :feature do
	
  scenario 'Create new question', js: true do
    visit questions_path

    page.execute_script("$('.js-MarkEditor').data('wysihtml5').editor.setValue('Kapan tanggal kemerdekaan Indonesia?');")
    fill_in 'question[answer]', with: '17 Agustus'
    find(:css, ".submitNewRecord").click

    wait_for_ajax

    expect(page).to have_content('Question was successfully created.')
  end

  scenario 'update a question', js: true do
  	@question = create(:question)

    visit questions_path
    find(:css, "span.glyphicon-edit").click
    page.execute_script("$('.js-MarkEditor').data('wysihtml5').editor.setValue('Kapan tanggal kemerdekaan Indonesia - Edit?');")
    fill_in 'question[answer]', with: '17 Agustus Edit'
    find(:css, ".submitUpdateRecord#{@question.id}").click

    wait_for_ajax
    
    expect(page).to have_content('Question was successfully updated.')
  end

  scenario 'destroy a question', js: true do
  	@question = create(:question)
  	
    visit questions_path
    find(:css, "span.glyphicon-trash").click
    click_on('Yes, delete!')

    wait_for_ajax

    expect(page).to have_no_content('Are you sure?')
  end

end