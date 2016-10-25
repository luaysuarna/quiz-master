class QuestionsController < ApplicationController
  before_action :set_question, only: [:update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # POST /questions
  # POST /questions.json
  def create
    question = Question.new(question_params)

    respond_to do |format|
      format.json do
        if question.save
          render json: success_api({questions: Question.to_api}, 'Question was successfully created.')
        else
          render json: failed_api({}, question.errors.full_messages.first)
        end
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      format.json do
        if @question.update(question_params)
          render json: success_api({ question: @question.to_api }, 'Question was successfully updated.')
        else
          render json: success_api({}, @question.errors.full_messages.first)
        end
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      format.json { render json: success_api({ question: @question.to_api}, 'Question was successfully destroyed.') }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content, :answer)
    end
end
