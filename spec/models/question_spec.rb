require 'rails_helper'

RSpec.describe Question, type: :model do

	before :each do
    @question = create(:question)
  end
  
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:answer) }

  describe "#to_api" do
    it 'return company in hash object' do
    	question_attributes = @question.to_api
    	expect(question_attributes.class).to eq Hash
    end

    it 'containing content truncate' do
    	question_attributes = @question.to_api
    	expect(question_attributes["content_truncate"]).to_not be_blank
    end
  end

  describe "ClassMethods" do
	  describe "#to_api" do
	    it 'containing question on array hash questions' do
	    	questions_attributes = Question.to_api
      	expect(questions_attributes).to eq [@question.to_api]
	    end

	    it 'containing hash object in array questions' do
	    	questions_attributes = Question.to_api
      	expect(questions_attributes.first.class).to eq Hash
	    end
	  end

	  describe '#take_question_exclude' do
	    it 'return a question' do
	    	question = Question.take_question_exclude
      	expect(question).to be_present
	    end
	  end
  end

end
