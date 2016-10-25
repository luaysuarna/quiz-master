require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:valid_attributes) {
    attributes_for(:question)
  }

  let(:invalid_attributes) {
    attributes_for(:question, answer: nil)
  }

  describe "GET #index" do
    it "assigns all questions as @questions" do
      question = create(:question)
      get :index
      expect(assigns(:questions)).to eq([question])
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template("index")
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before :each do
        post :create, question: valid_attributes, format: :json
      end

      it "created a new Question" do
        expect(Question.count).to eq(1)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "response with JSON body containing expected return success" do
        expect(response.body).to look_like_json
        expect(body_as_json["success"]).to eq true
      end
    end

    context "with invalid params" do
      before :each do
        post :create, question: invalid_attributes, format: :json
      end

      it "created a new Question" do
        expect(Question.count).to eq(0)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "response with JSON body containing expected return success" do
        expect(response.body).to look_like_json
        expect(body_as_json["success"]).to eq false
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      before :each do
        @question = create(:question)
        patch :update, question: {
            content: "Question Edit",
            answer: "Answer Edit"
          },
          id: @question.id,
          format: :json
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "response with JSON body containing expected Question attributes" do
        @question.reload

        expect(response.body).to look_like_json
        expect(body_as_json["question"]).to be_present
      end

      it "response with JSON body containing expected change content Question" do
        @question.reload
        expect(body_as_json["question"]["content"]).to eq "Question Edit"
      end
    end

    context "with invalid params" do
      before :each do
        @question = create(:question)
        patch :update, question: {
            content: "Question Edit",
            answer: nil
          },
          id: @question.id,
          format: :json
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "response with JSON body containing expected Question attributes" do
        @question.reload

        expect(response.body).to look_like_json
        expect(body_as_json["question"]).to be_blank
      end

      it "response with JSON body containing expected error message" do
        expect(body_as_json["message"]).to eq "Answer can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @question = create(:question)
      delete :destroy,
        id: @question.id,
        format: :json
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "response with JSON body containing expected Question attributes" do
      expect(response.body).to look_like_json
      expect(body_as_json["question"]).to be_present
    end

    it "response with JSON body containing expected message notice" do
      expect(body_as_json["message"]).to eq "Question was successfully destroyed."
    end
  end
end
