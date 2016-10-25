class Quiz < Tableless

	# Attributes
	attr_accessor :answer, :question_id

	# Validations
	validates :answer, :question_id, presence: true
	validate  :check_question

	# 
	# custom validation
	# 
	def check_question
		self.errors[:question_id] << "Question not found" if self.question.blank?
	end

	# 
	# check answer and return score
	# 
	def save!
		self.question.answer.match_deep(self.answer)
	end

	# 
	# get question based id
	# 
	def question
		Question.find(self.question_id) rescue nil
	end

end