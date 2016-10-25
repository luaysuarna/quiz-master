json.id @question.id
json.content @question.content
json.content_truncate truncate(strip_tags(@question.content), length: 50)
json.answer