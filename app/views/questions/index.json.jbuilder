json.questions @questions do |question|
	json.id question.id
	json.content_truncate truncate(strip_tags(question.content), length: 50)
	json.content question.content.html_safe
	json.answer question.answer
end