IndexQuestion = React.createClass
  
  getInitialState: ->
    showNewForm: false
    question: null
    questions: []

  componentWillMount: ->
    @setState(showNewForm: true) if _.isEmpty(@props.questions)
    @setState(questions: @props.questions) if @props.questions
    @setState(question: @props.question) if @props.question

  _onChangeQuestions: (questions) ->
    @setState(questions: questions) 

  _onChangeShowForm: ->
    @setState(showNewForm: true)

  _onCancelShowForm: ->
    @setState(showNewForm: false)

  _onEditQuestion: (e) ->
    $el = $(e.target)
    question = _.find(@state.questions, ['id', $el.data('id')])
    @setState(question: question)
    @_onChangeShowForm()

  render: ->
    { showNewForm, questions } = @state

    <div className='app'>
      {
        if showNewForm
          <FormQuestion handleOnChangeQuestions={@_onChangeQuestions} handleOnCancelShowForm={@_onCancelShowForm} />
      }
      { 
        if !_.isEmpty(questions)
          <div className='item row'>
            <div className='col-sm-8'>
              <h4>List Questions</h4>
              <div className='btn-control add-button'>
                <button type="button" className="btn btn-default add-question" onClick={@_onChangeShowForm}>
                  <span className='glyphicon glyphicon-plus'></span>
                </button>
              </div>
            </div>
          </div>
      }
      {
        _.map questions, (item) ->
          <Question question={item} key={item.id} />
      }
    </div>

window.IndexQuestion = IndexQuestion