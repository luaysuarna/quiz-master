class Question < ActiveRecord::Base

	# Validations
	validates :content, :answer, presence: true

	# return api attributes
	def to_api
		self.attributes.merge('content_truncate' => ActionController::Base.helpers.strip_tags(self.content).truncate(50))
	end

	# ClassMethods
	class << self

		# return collection of question
		def to_api
       all.map { |question| question.attributes.merge('content_truncate' => ActionController::Base.helpers.strip_tags(question.content).truncate(50)) }
		end

		# return random question
		def take_question_exclude
			sample_ids = Question.pluck(:id)
			return find(sample_ids.sample) rescue nil
		end
	end

end
