Question = React.createClass
  
  getInitialState: ->
    showEditForm: false
    question: null

  componentWillMount: ->
    @setState(question: @props.question)

  _onChangeShowForm: ->
    @setState(showEditForm: true)

  _onCancelShowForm: ->
    @setState(showEditForm: false)

  _onUpdateQuestion: (question) ->
    $(@refs.questionContent).html(question.content_truncate)
    @setState(question: question)

  _onConfirmDelete: ->
    _reactClass = @

    swal {
      title: 'Are you sure?'
      text: 'You will remove this question!'
      type: 'warning'
      showCancelButton: true
      confirmButtonColor: '#DD6B55'
      confirmButtonText: 'Yes, delete!'
      cancelButtonText: 'No, cancel!'
      closeOnConfirm: true
      closeOnCancel: true
    }, (isConfirm) ->
      if isConfirm
        $(_reactClass.refs.rootList).hide()
        $.ajax
          method: 'DELETE'
          url: Routes.question_path(_reactClass.props.question.id, format: 'json', method: 'delete')
          dataType: 'JSON'
          success: (response) =>
            Alert.displaySuccess(response.message)
        

  render: ->
    { showEditForm, question } = @state

    <div ref='rootList' className='list'>
      {
        if showEditForm
          <FormQuestion question={question} handleOnCancelShowForm={@_onCancelShowForm} handleOnUpdateQuestion={@_onUpdateQuestion} />
      }

      <div className="item row #{ 'hide' if showEditForm }">
        <div className='col-sm-1 content left text-center'>{question.id}</div>
        <div className='col-sm-6 content right' ref='questionContent'>{question.content_truncate}</div>
        <div className='col-sm-2 btn-control text-left'>
          <button type="button" className="btn btn-default" onClick={@_onChangeShowForm}>
            <span className='glyphicon glyphicon-edit'></span>
          </button>
          <button type="button" className="btn btn-default" onClick={@_onConfirmDelete}>
            <span className='glyphicon glyphicon-trash' ></span>
          </button>
        </div>
      </div>
    </div>

window.Question = Question