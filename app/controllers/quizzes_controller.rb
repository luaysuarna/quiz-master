class QuizzesController < ApplicationController

  before_action :set_question, only: [:take_quiz]

  # GET /quizzes/take_quiz
  # GET /quizzes/take_quiz.json
  def take_quiz
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    quiz = Quiz.new(set_quiz_params)

    respond_to do |format|
      format.json do
        
        if quiz.valid?
          if quiz.save!
            render json: success_api({ question: quiz.question }, "You fill correct answer!")
          else
            render json: failed_api({ question: quiz.question }, "You fill incorrect answer!")
          end
        else
          render json: failed_api({}, quiz.errors.full_messages.first)
        end
      end
    end
  end

  private

    # setup random question
    def set_question
      @question = Question.take_question_exclude
    end

    # params permit
    def set_quiz_params
      params.require(:quiz).permit(:answer, :question_id)
    end
end
