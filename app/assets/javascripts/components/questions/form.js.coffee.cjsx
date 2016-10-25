FormQuestion = React.createClass
  
  getInitialState: ->
    isNewRecord: true
    questionContent: ''
    questionAnswer: ''

  componentWillMount: ->
    if @props.question
      @setState(questionContent: @props.question.content)
      @setState(questionAnswer: @props.question.answer)
      @setState(isNewRecord: false)

  componentDidMount: ->
    MarkEditor::initialize()

  _onSubmitHandler: (e) ->
    if @_isValid()
      data        = $(e.target).serializeArray()
      _reactClass = @

      if @state.isNewRecord
        $.post Routes.questions_path(format: 'json', ), data, (response) =>
          _reactClass._callbackResponse(response)
      else
        $.ajax
          method: 'PATCH'
          url: Routes.question_path(_reactClass.props.question.id, format: 'json')
          dataType: 'JSON'
          data: data
          success: (response) =>
            _reactClass._callbackResponse(response)

    e.preventDefault()

  _callbackResponse: (response) ->
    if response.success
      Alert.displaySuccess(response.message)
      @props.handleOnChangeQuestions(response.questions) if @state.isNewRecord
      @props.handleOnUpdateQuestion(response.question) if !@state.isNewRecord
      @props.handleOnCancelShowForm()
    else
      Alert.displayError(response.message)

  _isValid: ->
    { questionContent, questionAnswer } = @refs

    Validate::successTagWrapper($('form'))
    errors = []

    errors.push({ id: 'questionContent', message: 'can not be blank' }) if _.isEmpty(questionContent.value)
    errors.push({ id: 'questionAnswer', message: 'can not be blank' }) if _.isEmpty(questionAnswer.value)

    if _.isEmpty(errors)
      return true
    else
      @setState(errors: errors)

      _.map errors, (error) ->
        Validate::errorTag($("##{error.id}"), error.message)

      return false

  _onHandleChange: (e) ->
    @setState("#{e.target.getAttribute('id')}": e.target.value)

  render: ->
    { isNewRecord, questionContent, questionAnswer } = @state

    <div className='form'>
      <br />
      <br />
      <div className="panel panel-default">
        <div className="panel-heading">
          <strong>
            {
              if isNewRecord then 'ADD NEW QUESTION' else "EDIT QUESTION #{@props.question.id}"
            }
          </strong>
        </div>
        <div className="panel-body">
          <form className='new-question' onSubmit={@_onSubmitHandler}>
            <div className='row'>
              <div className='col-sm-12'>
                <div className='form-group'>
                  <label>Content question</label>
                  <div>
                    <textarea
                      name='question[content]'
                      className='form-control required js-MarkEditor'
                      ref='questionContent'
                      id='questionContent'
                      onChange={@_onHandleChange}
                      value={questionContent}
                      ></textarea>
                  </div>
                </div>
              </div>
              <div className='col-md-4 col-sm-12'>
                <div className='form-group'>
                  <label>Answer</label>
                  <div>
                    <input
                      name='question[answer]'
                      className='form-control required'
                      ref='questionAnswer'
                      id='questionAnswer'
                      value={questionAnswer}
                      onChange={@_onHandleChange}
                      />
                  </div>
                </div>
              </div>
            </div>
            <hr />
            <div className='button-wrapper'>
              <a href='javascript:void(0)' className='btn btn-danger' onClick={@props.handleOnCancelShowForm}>CANCEL</a>
              &nbsp;
              {
                if isNewRecord
                  <input type='submit' className="btn btn-primary submitNewRecord" value='SAVE' />
                else
                  <input type='submit' className="btn btn-primary #{'submitUpdateRecord' + @props.question.id}" value='SAVE' />
              }
            </div>
          </form>
        </div>
      </div>
    </div>

window.FormQuestion = FormQuestion
