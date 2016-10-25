TakeQuiz = React.createClass

  getInitialState: ->
    question: ''

  componentWillMount: ->
    @setState(question: @props.question)

  _onSubmitQuestion: (e) ->
    $el  = $(e.target)
    $tag = $(@refs.questionContent)
    _reactClass = @

    if $tag.val()
      Validate::successTag($tag)
      $.post Routes.quizzes_path(format: 'json'), $el.serializeArray(), (response) =>
        if response.success
          swal("Good job!", response.message, "success")
        else
          swal("Attantion!", response.message, "error")

        _reactClass.setState(question: response.question)
    else
      Validate::errorTag($tag, "can not be blank.")

    e.preventDefault()

  
  render: ->
    { question } = @state

    <div className='app container-content'>
      <h2>Take a Quiz!</h2>
      <br />
      <div className='main-content'>
        <h4>{question.content}</h4>
        <hr />
        <form onSubmit={@_onSubmitQuestion}>
          <input type='hidden' ref='questionId' name='quiz[question_id]' value={question.id} />
          <div className='form-group'>
            <input type='text' className='form-control' ref='questionContent' name='quiz[answer]' placeholder='Your answer.' />
          </div>
          <div>
            <span className='pull-right'>
              <input type='submit' value='Submit' className='btn btn-primary' />
            </span>
            <div className='clearfix'></div>
          </div>
        </form>
      </div>
      <br />
      <div className='pull-right'>
        Answer: {question.answer}
      </div>
    </div>

window.TakeQuiz = TakeQuiz