require 'rails_helper'

RSpec.describe QuizzesController, type: :controller do

  describe "GET #take_quiz" do
    before :each do
      @question = create(:question)
    end

    it "question should be equal to @question" do
      get :take_quiz
      expect(assigns(:question)).to eq @question
    end

    it 'renders take_quiz template' do
      get :take_quiz
      expect(response).to render_template("take_quiz")
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    before :each do
      @question = create(:question)
    end

    it "question should be equal to @question" do
      get :take_quiz
      expect(assigns(:question)).to eq @question
    end

    it 'renders take_quiz template' do
      get :take_quiz
      expect(response).to render_template("take_quiz")
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid answer" do
      before :each do
        @question = create(:question)
      end

      it "return json format" do
        post :create, quiz: { question_id: @question.id, answer: '17 AGUSTUS'  }, format: :json
        expect(response.body).to look_like_json
      end

      it "return containing success message" do
        post :create, quiz: { question_id: @question.id, answer: '17 AGUSTUS'  }, format: :json
        expect(body_as_json["message"]).to eq "You fill correct answer!"
      end

      it "with upcase answer 17 AGUSTUS " do
        post :create, quiz: { question_id: @question.id, answer: '17 AGUSTUS'  }, format: :json
        expect(body_as_json["success"]).to eq true
      end

      it "with downcase answer 17 agustus " do
        post :create, quiz: { question_id: @question.id, answer: '17 agustus'  }, format: :json
        expect(body_as_json["success"]).to eq true
      end

      it "with mixcase answer 17 AGUstus " do
        post :create, quiz: { question_id: @question.id, answer: '17 AGUstus'  }, format: :json
        expect(body_as_json["success"]).to eq true
      end

      it "with distance wrong word answer 17 Agustuss " do
        post :create, quiz: { question_id: @question.id, answer: '17 Agustuss'  }, format: :json
        expect(body_as_json["success"]).to eq true
      end

      it "with replace number to word answer seventeen Agustus " do
        post :create, quiz: { question_id: @question.id, answer: 'seventeen agustus'  }, format: :json
        expect(body_as_json["success"]).to eq true
      end
    end

    context "with invalid answer" do
      before :each do
        @question = create(:question)
      end

      it "return json format" do
        post :create, quiz: { question_id: @question.id, answer: nil  }, format: :json
        expect(response.body).to look_like_json
      end

      it "return containing error message" do
        post :create, quiz: { question_id: @question.id, answer: "17 Dec"  }, format: :json
        expect(body_as_json["message"]).to eq "You fill incorrect answer!"
      end

      it "return message validation with nil answer" do
        post :create, quiz: { question_id: @question.id, answer: nil  }, format: :json
        expect(body_as_json["message"]).to eq "Answer can't be blank"
      end

      it "with nil answer" do
        post :create, quiz: { question_id: @question.id, answer: nil  }, format: :json
        expect(body_as_json["success"]).to eq false
      end

      it "with wrong second word 17 may " do
        post :create, quiz: { question_id: @question.id, answer: '17 may'  }, format: :json
        expect(body_as_json["success"]).to eq false
      end

      it "with wrong first word 20 Agustus " do
        post :create, quiz: { question_id: @question.id, answer: '20 Agustus'  }, format: :json
        expect(body_as_json["success"]).to eq false
      end

      it "with wronng answer 19 June" do
        post :create, quiz: { question_id: @question.id, answer: '19 June'  }, format: :json
        expect(body_as_json["success"]).to eq false
      end

      it "with to far distance wrong word answer 17 Agustis" do
        post :create, quiz: { question_id: @question.id, answer: '17 Agustiis'  }, format: :json
        expect(body_as_json["success"]).to eq false
      end

      it "with wrong convert number seven teen agustus" do
        post :create, quiz: { question_id: @question.id, answer: 'seven teen agustus'  }, format: :json
        expect(body_as_json["success"]).to eq false
      end
    end
  end

end
