require 'rails_helper'

RSpec.describe Quiz, type: :model do

	before :each do
    @question = create(:question)
  end

  it { should validate_presence_of(:question_id) }
  it { should validate_presence_of(:answer) }

  describe "#check_question" do
    it 'return not valid with wrong question_id' do
    	id   = @question.id + 1
    	quiz = Quiz.new(answer: 'Test', question_id: id)
    	expect(quiz.valid?).to eq false
    end

    it 'return valid with question_id' do
    	quiz = Quiz.new(answer: 'Test', question_id: @question.id)
    	expect(quiz.valid?).to eq true
    end
  end

  describe "#save!" do
  	it 'return valid answer with same answer' do
  		quiz = Quiz.new(answer: @question.answer, question_id: @question.id)
    	expect(quiz.save!).to eq true
  	end

  	it 'return valid answer with word date' do
  		quiz = Quiz.new(answer: 'seventeen agustus', question_id: @question.id)
    	expect(quiz.save!).to eq true
  	end

  	it 'return valid answer with fuzzle word' do
  		quiz = Quiz.new(answer: 'seventien agustus', question_id: @question.id)
    	expect(quiz.save!).to eq true
  	end

  	it 'return not valid answer with long distance fuzzle word' do
  		quiz = Quiz.new(answer: 'sefentoon agustus', question_id: @question.id)
    	expect(quiz.save!).to eq false
  	end  	
  end

end
