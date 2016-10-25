Alert = React.createClass
  propTypes:
    type: React.PropTypes.string.isRequired # 'error' or 'success'
    message: React.PropTypes.string.isRequired

  getInitialState: ->
    {
      type: @props.type
      message: @props.message
    }

  componentDidMount: ->
    @_handleMessageUpdate()
    @mounted = true

  componentDidUpdate: ->
    @_handleMessageUpdate()

  componentWillUnmount: ->
    @mounted = false

  _handleMessageUpdate: ->
    if @state.message
      $(ReactDOM.findDOMNode(@)).show()
      @_setHideTimeout()
    else
      $(ReactDOM.findDOMNode(@)).hide()

  _setHideTimeout: ->
    setTimeout( =>
      if @mounted
        $(ReactDOM.findDOMNode(@)).fadeOut =>
          @setState(message: '')
    , 5000)

  render: ->
    {onClickCloseButton} = @
    {type, message} = @state

    _alertClass = if type == 'error' then 'alert-danger' else "alert-#{type}"
    alertClass = "alert alert-dismissable #{_alertClass}"

    <div className="error-message">
      <div className={alertClass}>
        <button className="close" aria-hidden="true" type="button"
          onClick={onClickCloseButton}>&times</button>
        <span className="message">{message}</span>
      </div>
    </div>

  onClickCloseButton: ->
    $(ReactDOM.findDOMNode(@)).hide()

  displaySuccess: (message) ->
    @setState({ type: 'success', message: message })

  displayError: (message) ->
    @setState({ type: 'error', message: message })

  statics:
    displaySuccess: (message) ->
      node    = $('[data-react-class="Alert"]')[0]
      element = React.createElement(Alert, { type: 'success', message: message })

      ReactDOM.unmountComponentAtNode(node)
      ReactDOM.render(element, node)

    displayError: (message) ->
      node    = $('[data-react-class="Alert"]')[0]
      element = React.createElement(Alert, { type: 'error', message: message })

      ReactDOM.unmountComponentAtNode(node)
      ReactDOM.render(element, node)

window.Alert = Alert
