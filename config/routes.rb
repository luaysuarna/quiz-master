Rails.application.routes.draw do

  root to: 'welcomes#index'

  resources :welcomes,  only: :index
  resources :questions, only: [:index, :create, :update, :show, :destroy]
  resources :quizzes,   only: [:index, :create] do
    collection do
      get :take_quiz
    end
  end
end
